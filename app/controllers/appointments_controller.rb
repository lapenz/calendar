class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:schedule, :hours, :checkout, :create_appointment, :resume, :check]
  load_and_authorize_resource except: [:schedule, :hours, :checkout, :create_appointment, :resume, :check]
  skip_authorize_resource :only => [:schedule, :hours, :checkout, :create_appointment, :resume, :check]
  helper CompaniesHelper, ApplicationHelper
  layout "client", only: :create_appointment

  # GET /appointments
  # GET /appointments.json
  #/myfeed.php?start=2013-12-01&end=2014-01-12&_=1386054751381
  def index
    @appointments = Appointment.where(company: current_user.company, :start => params[:start]..params[:end])
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
    @appointment.client = Client.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    @appointment = Appointment.new(appointment_params)
    client = Client.where(email: appointment_params[:client_attributes][:email]).where.not(email: [nil, '']).first_or_initialize
    client.company = current_user.company
    client.name = appointment_params[:client_attributes][:name] unless appointment_params[:client_attributes][:name].blank?
    client.phone = appointment_params[:client_attributes][:phone] unless appointment_params[:client_attributes][:phone].blank?

    @appointment.client = client
    @appointment.company = current_user.company
    @appointment.end = @appointment.start + appointment_params[:duration].to_i.seconds

    @appointment.repeat = nil if(@appointment.repeat.present? && @appointment.repeat.typerepeat.blank?)

    respond_to do |format|
      if @appointment.save

        if (@appointment.repeat.present? && !@appointment.repeat.typerepeat.blank?)
          repeatAppointments = createRepeats @appointment
          repeatAppointments.each {|o| o.save}
        end
        AppointmentConfirmMailerJob.perform_later(@appointment, 'confirmado')
        format.html { redirect_to @appointment, notice: 'Agendamento criado com sucesso.' }
        format.json { render :show, status: :created, location: @appointment }
      else
        format.html { render :new }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /appointments/1
  # PATCH/PUT /appointments/1.json
  def update
    start = Time.zone.local(appointment_params["start(1i)"].to_i,
                                        appointment_params["start(2i)"].to_i,
                                        appointment_params["start(3i)"].to_i,
                                        appointment_params["start(4i)"].to_i,
                                        appointment_params["start(5i)"].to_i)
    reprogrammed = start != @appointment.start
    @appointment.end = start + appointment_params[:duration].to_i.seconds

    respond_to do |format|
      if @appointment.update(appointment_params)
        AppointmentConfirmMailerJob.perform_later(@appointment, 'reprogramado') if reprogrammed
        format.html { redirect_to @appointment, notice: 'Agendamento atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @appointment }
      else
        format.html { render :edit }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /appointments/1
  # DELETE /appointments/1.json
  def destroy
    repeat = @appointment.repeat
    @appointment.destroy

    repeat.destroy if !repeat.nil? && repeat.appointments.empty?
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Agendamento destruído com sucesso.' }
      format.json { head :no_content }
    end
  end

  def destroyRepeat
    repeat = @appointment.repeat
    appointments = repeat.appointments
    appointments = appointments.where('start >= ? ', @appointment.start)
    appointments.destroy_all
    repeat.destroy if repeat.appointments.empty?
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Agendamentos destruídos com sucesso.' }
      format.json { head :no_content }
    end
  end

  def schedule
    @appointment = Appointment.new
    @company_service = CompaniesService.find(params[:id]);
    @company = @company_service.company
    @resources = @company_service.resources
    render layout: "client"
  end

  def checkout
    @appointment = Appointment.new(appointment_params)
    @company = @appointment.companies_service.company
    @client = Client.new
    @client.appointments.build(appointment_params)
    render layout: "client"

  end

  # POST /clients
  # POST /clients.json
  def create_appointment
    @appointment = Appointment.new(appointment_params)
    @company = @appointment.companies_service.company

    client = Client.where(email: appointment_params[:client_attributes][:email]).where.not(email: [nil, '']).first_or_initialize
    client.name = appointment_params[:client_attributes][:name] unless appointment_params[:client_attributes][:name].blank?
    client.phone = appointment_params[:client_attributes][:phone] unless appointment_params[:client_attributes][:phone].blank?
    client.company = @appointment.companies_service.company
    client.full_validate = true
    @appointment.client = client
    @appointment.company = @appointment.companies_service.company

    @appointment.end = @appointment.start + @appointment.companies_service.duration.seconds

    respond_to do |format|
      if @appointment.save
        AppointmentConfirmMailerJob.perform_later(@appointment, 'confirmado')
        format.html { redirect_to resume_appointments_path(Id: @appointment.hashId), notice: 'Agendamento criado com sucesso.' }
        format.json { render :show, status: :created, location: @appointment}
      else
        format.html { render action: :checkout }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def resume
    id = ApplicationHelper.decrypt('ajweidi234idfh35', params[:Id])
    @appointment = Appointment.find(id.to_i)
    @company = @appointment.companies_service.company
    render layout: "client"
  end


  def hours

    date = Date.parse(params[:date])

    companiesService = CompaniesService.find(params[:companies_service_id])
    openingHours = OpeningHour.by_weekday(date.wday).where(company: companiesService.company)

    releasedHours = []
    openingHours.each do |oh|
      releasedHours |= getReleasedHours(oh, date)
    end

    unavailableHours = Appointment.where(:resource_id => params[:resource_id], :start => date.beginning_of_day..date.end_of_day)

    @openHours = getOpenHours(params, releasedHours, unavailableHours)
    render layout: false
  end

  def check
    company = Company.find(params[:company_id])
    client = Client.where(email: params[:email], company: company).first
    appointments = Appointment.where(client: client).where('start >= ?', Time.now).order(:start)
    msg = ""
    if client.nil?
      msg = 'Cliente não encontrado. Verifique o email e tente novamente.'
    elsif appointments.empty?
      msg = 'Nenhum agendamento encontrado para o email informado.'
    else
      AppointmentsMailer.check_appointments(client, appointments).deliver_now
      msg = 'Os agendamentos foram enviados para o email informado!'
    end

    respond_to do |format|
      format.json { render :json => msg.to_json }
    end
  end

  private
  # Remove os horarios ocupados da lista <releasedHours> e retorna uma lista com os horarios disponiveis
  def getOpenHours (params, releasedHours, unavailableHours)

    companiesService = CompaniesService.find(params[:companies_service_id])

    results = Array.new

    releasedHours.each do |rh|
      catch :jump_it do
        initialReleasedHour = rh
        finalReleasedHour = rh + companiesService.duration.seconds

        unavailableHours.each do |app|
          throw :jump_it if ((app.start <= initialReleasedHour && app.end >= finalReleasedHour) || app.start.between?(initialReleasedHour, finalReleasedHour) || app.end.between?(initialReleasedHour, finalReleasedHour))
        end

        results << initialReleasedHour
        #      @openHours << initialReleasedHour if Appointment.where("(start <= '#{initialReleasedHour.to_s}' AND end >= '#{finalReleasedHour.to_s}')
        # OR (start between '#{initialReleasedHour}' and '#{finalReleasedHour}') OR (end between '#{initialReleasedHour}' and '#{finalReleasedHour}')").blank?
      end
    end
    return results
  end

  # Retorna uma lista com os horarios possiveis dentro de um OpeningHour de acordo com o intervalo configurado.
  def getReleasedHours (openingHour, date)
    releasedHours = []
    tempHour = openingHour.from
    interval = openingHour.company.schedule_interval

    # Enquanto o tempHour estiver no intervalo do OpeningHour e o interval for maior que 0 vai incrementando o tempHour
    while tempHour.between?(openingHour.from, openingHour.to) && interval > 0  do
      releasedHours << Time.zone.local(date.year, date.month, date.day, tempHour.hour, tempHour.min, tempHour.sec)
      tempHour += interval
    end

    return releasedHours
  end

  def createRepeats(appointment)
    if(appointment.repeat.typerepeat == 'monthly')
      occurencys = (appointment.repeat.end.year * 12 + appointment.repeat.end.month) - (appointment.start.year * 12 + appointment.start.month)
      appointments = Array.new
      intervalCount = 0
      for i in 1..occurencys
        intervalCount += 1
        if(appointment.repeat.interval == intervalCount)
          appointmentAux = appointment.dup
          appointmentAux.start = appointment.start + i.month
          appointmentAux.end = appointment.end + i.month
          appointments << appointmentAux
          intervalCount = 0

        end
      end

      return appointments
    end

    if(appointment.repeat.typerepeat == 'weekly')
      appointments = Array.new
      dates = []

      appointment.repeat.weekdays.each {|weekday|
        dates += (appointment.start.to_date..appointment.repeat.end.to_date).select{|x| x.wday == weekday.to_i }
      }

      calendarWeeks = []
      (appointment.start.to_date..appointment.repeat.end.to_date).each {|date|
        calendarWeeks.push(date.cweek) unless calendarWeeks.include?(date.cweek)
      }

      return appointments if dates.empty?

      interval = appointment.repeat.interval

      intervalCount = interval
      calendarWeeksWithInterval = []
      calendarWeeks.each {|week|
        if intervalCount == interval
          calendarWeeksWithInterval << week
          intervalCount = 0
        end

        intervalCount += 1

      }

      dates.each {|date|
        next if !calendarWeeksWithInterval.include? date.cweek

        appointmentAux = appointment.dup
        appointmentAux.start = appointment.start.change(day: date.day, year: date.year, month: date.month)
        appointmentAux.end = appointment.end.change(day: date.day, year: date.year, month: date.month)
        appointments << appointmentAux

      }

      return appointments
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def appointment_params
    params.require(:appointment).permit(:companies_service_id, :resource_id, :client_id, :repeat_id, :title, :start, :end, :duration, :allday, :obs, :price, :name, :email, :phone, client_attributes: [:email, :name, :phone], repeat_attributes: [:typerepeat, :interval, :end, weekdays: []])
  end

end
