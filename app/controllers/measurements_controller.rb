class MeasurementsController < ApplicationController
  before_action :set_device
  before_action :set_measurement, only: [ :show, :edit, :update, :destroy ]

  # GET /measurements or /measurements.json
  def index
    @measurements = @device.measurements

    respond_to do |format|
      format.html
      format.json { render json: @measurements }
    end
  end

  def show
  end

  # GET /devices/new
  def new
    @measurement = @device.measurements.build
  end

  # GET /devices/1/edit
  def edit
  end

  def create
    @measurement = @device.measurements.build(measurement_params)

    respond_to do |format|
      if @measurement.save
        format.html { redirect_to device_measurement_path(@device), notice: "Measurement was successfully created." }
        format.json { render :show, status: :created, location: @measurement }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @measurement.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /devices/1 or /devices/1.json
  def update
    respond_to do |format|
      if @measurement.update(measurement_params)
        format.html { redirect_to device_measurement_path(@device), notice: "Measurement was successfully updated.", status: :see_other }
        format.json { render :show, status: :ok, location: @measurement }
      else
        format.html { render :edit, status: :unprocessable_content }
        format.json { render json: @measurement.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /devices/1 or /devices/1.json
  def destroy
    @measurement.destroy!

    respond_to do |format|
      format.html { redirect_to device_measurements_path(@device), notice: "Measurement was successfully destroyed.", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Current.user.devices.find(params[:device_id])
    end

    def measurement_params
      params.require(:measurement).permit(:temperature, :humidity)
    end

    def set_measurement
      @measurement= @device.measurements.find(params[:id])
    end
end
