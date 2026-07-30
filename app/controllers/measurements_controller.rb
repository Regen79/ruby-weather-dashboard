class MeasurementsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create ]
  skip_before_action :require_authentication, only: [ :create]
  before_action :set_device_for_web, only: [ :index ]
  before_action :set_device_by_token, only: [ :create ]


  # GET /measurements or /measurements.json
  def index
    @measurements = @device.measurements

    respond_to do |format|
      format.html
      format.json {render json: @measurements}
    end
  end

  def create

    @measurement=@device.measurements.build(measurement_params)
    
    respond_to do |format|
      if @measurement.save
        format.json {render json: { message: "Measurement saved correct", measurement: @measurement }, status: :created}
        format.html {render json: { message: "Measurement saved correct", measurement: @measurement }, status: :created}
      else
        format.json { render json: { message: "Error saving measurement", errors: @measurement.errors }, status: :unprocessable_entity }
        format.html { render json: { message: "Error saving measurement", errors: @measurement.errors }, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device_for_web
      @device = Current.user.devices.find(params[:device_id])
    end
    
    
    def set_device_by_token
      token=request.headers["Authorization"]&.split(" ")&.last
      @device=Device.find_by(api_key: token)

      unless @device
        render json: {error: "Incorrect Api token"}, status: :unauthorized
      end
    end
        
    def measurement_params
      params.require(:measurement).permit(:temperature, :humidity)
    end
end
  