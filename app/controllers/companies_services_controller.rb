class CompaniesServicesController < ApplicationController
  before_action :set_companies_service, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /companies_services
  # GET /companies_services.json
  def index
    @companies_services = CompaniesService.all
  end

  # GET /companies_services/1
  # GET /companies_services/1.json
  def show
  end

  # GET /companies_services/new
  def new
    @companies_service = CompaniesService.new
  end

  # GET /companies_services/1/edit
  def edit
  end

  # POST /companies_services
  # POST /companies_services.json
  def create
    @companies_service = CompaniesService.new(companies_service_params)

    service = Service.find_by(name: companies_service_params['service_name'])
    if service.nil?
      service = Service.create(:name => companies_service_params['service_name'])
    end
    @companies_service.service_id = service.id

    respond_to do |format|
      if @companies_service.save
        format.html { redirect_to @companies_service, notice: 'Companies service was successfully created.' }
        format.json { render :show, status: :created, location: @companies_service }
      else
        format.html { render :new }
        format.json { render json: @companies_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /companies_services/1
  # PATCH/PUT /companies_services/1.json
  def update
    respond_to do |format|
      if @companies_service.update(companies_service_params)
        format.html { redirect_to @companies_service, notice: 'Companies service was successfully updated.' }
        format.json { render :show, status: :ok, location: @companies_service }
      else
        format.html { render :edit }
        format.json { render json: @companies_service.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies_services/1
  # DELETE /companies_services/1.json
  def destroy
    @companies_service.destroy
    respond_to do |format|
      format.html { redirect_to companies_services_url, notice: 'Companies service was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_companies_service
      @companies_service = CompaniesService.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def companies_service_params
      params.require(:companies_service).permit(:company_id, :service_name, :duration, :description, :price, :date, :provider_ids => [])
    end
end
