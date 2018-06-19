class AppointmentsController < ApplicationController
  before_action :set_appointment, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:schedule, :hours, :checkout, :create_appointment, :resume, :check]
  load_and_authorize_resource
  skip_authorize_resource :only => [:schedule, :hours, :checkout, :create_appointment, :resume, :check]
  helper CompaniesHelper, ApplicationHelper
  layout "client", only: :create_appointment

  # GET /appointments
  # GET /appointments.json
  #/myfeed.php?start=2013-12-01&end=2014-01-12&_=1386054751381
  def index
    @appointments = Appointment.joins(:companies_service).where(companies_services: { company_id: current_user.company.id}, :start => params[:start]..params[:end])
  end

  # GET /appointments/1
  # GET /appointments/1.json
  def show
  end

  # GET /appointments/new
  def new
    @appointment = Appointment.new
  end

  # GET /appointments/1/edit
  def edit
  end

  # POST /appointments
  # POST /appointments.json
  def create
    if !appointment_params[:client_attributes][:name].blank?
      client = Client.where(email: appointment_params[:client_attributes][:email]).first_or_initialize
      client.name = appointment_params[:client_attributes][:name] unless appointment_params[:client_attributes][:name].blank?
      client.phone = appointment_params[:client_attributes][:phone] unless appointment_params[:client_attributes][:phone].blank?
      client.company = current_user.company
    end

    @appointment = Appointment.new(appointment_params)

    @appointment.client = client
    @appointment.end = @appointment.start + appointment_params[:duration].to_i.seconds

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: 'Appointment was successfully created.' }
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
    @appointment.end = @appointment.start + appointment_params[:duration].to_i.seconds
    @appointment.title = @appointment.companies_service.service.name

    respond_to do |format|
      if @appointment.update(appointment_params)
        format.html { redirect_to @appointment, notice: 'Appointment was successfully updated.' }
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
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: 'Appointment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def schedule
    @appointment = Appointment.new
    @company_service = CompaniesService.find(params[:id]);
    @resources = @company_service.resources
    render layout: false
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
    client = Client.where(email: appointment_params[:client_attributes][:email]).first_or_initialize
    client.name = appointment_params[:client_attributes][:name] unless appointment_params[:client_attributes][:name].blank?
    client.phone = appointment_params[:client_attributes][:phone] unless appointment_params[:client_attributes][:phone].blank?

    client.full_validate = true

    @appointment = Appointment.new(appointment_params)

    client.company = @company = @appointment.companies_service.company

    @appointment.client = client
    @appointment.end = @appointment.start + @appointment.companies_service.duration.seconds

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to resume_appointments_path(Id: @appointment.hashId), notice: 'Appointment was successfully created.' }
        format.json { render :show, status: :created, location: @appointment}
      else
        format.html { render action: :checkout }
        format.json { render json: @appointment.errors, status: :unprocessable_entity }
      end
    end
  end

  def resume
    id = ApplicationHelper.decrypt('agendacard', params[:Id])
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
      #byebug
      releasedHours << Time.new(date.year, date.month, date.day, tempHour.hour, tempHour.min, tempHour.sec).in_time_zone(Time.zone)
      tempHour += interval
    end

    return releasedHours
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_appointment
    @appointment = Appointment.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def appointment_params
    params.require(:appointment).permit(:companies_service_id, :resource_id, :title, :start, :end, :duration, :all_day, :obs, :price, :name, :email, :phone, client_attributes: [:id, :email, :name, :phone])
  end

end
