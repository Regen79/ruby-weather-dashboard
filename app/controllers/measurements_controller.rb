class MeasurementsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create ]
  skip_before_action :require_authentication, only: [ :create ]
  before_action :set_device, only: [ :index, :create ]
 


  # GET /measurements or /measurements.json
  def index
    @measurements = @device.measurements

    respond_to do |format|
      format.html
      format.json { render json: @measurements }
    end
  end

  def create
    @measurement = @device.measurements.build(measurement_params)
    respond_to do |format|
      if @measurement.save
        format.json { render json: { message: "Measurement saved correct", measurement: @measurement }, status: :created }
        format.html { redirect_to measurements_path, notice: "Measurement was successfully created." }
      else
        format.json { render json: { message: "Error saving measurement", errors: @measurement.errors }, status: :unprocessable_entity }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      if request.format.json? && request.headers["Authorization"].present?
        token=request.headers["Authorization"]&.split(" ")&.last
        @device=Device.find_by(api_key: token)
        unless @device
          render json: { error: "Incorrect Api token" }, status: :unauthorized and return
        end
      else
        @device = Current.user.devices.find(params[:device_id])
      end
    end

    def measurement_params
      params.require(:measurement).permit(:temperature, :humidity)
    end
end

