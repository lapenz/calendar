class OpeningHoursController < ApplicationController
  before_action :set_opening_hour, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /opening_hours
  # GET /opening_hours.json
  def index
    @opening_hours = OpeningHour.all
  end

  # GET /opening_hours/1
  # GET /opening_hours/1.json
  def show
  end

  # GET /opening_hours/new
  def new
    @opening_hour = OpeningHour.new
  end

  # GET /opening_hours/1/edit
  def edit
  end

  # POST /opening_hours
  # POST /opening_hours.json
  def create
    @opening_hour = OpeningHour.new(opening_hour_params)
    respond_to do |format|
      if @opening_hour.save
        format.html { redirect_to @opening_hour, notice: 'Opening hour was successfully created.' }
        format.json { render :show, status: :created, location: @opening_hour }
      else
        format.html { render :new }
        format.json { render json: @opening_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /opening_hours/1
  # PATCH/PUT /opening_hours/1.json
  def update
    respond_to do |format|
      if @opening_hour.update(opening_hour_params)
        format.html { redirect_to @opening_hour, notice: 'Opening hour was successfully updated.' }
        format.json { render :show, status: :ok, location: @opening_hour }
      else
        format.html { render :edit }
        format.json { render json: @opening_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /opening_hours/1
  # DELETE /opening_hours/1.json
  def destroy
    @opening_hour.destroy
    respond_to do |format|
      format.html { redirect_to opening_hours_url, notice: 'Opening hour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_opening_hour
      @opening_hour = OpeningHour.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def opening_hour_params
      params.require(:opening_hour).permit(:company_id, :provider_id, :from, :to, :weekdays => [])
    end
end
