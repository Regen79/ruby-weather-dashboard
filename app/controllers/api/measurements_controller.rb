class Api::MeasurementsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :create ]
  skip_before_action :require_authentication, only: [ :create ]

  before_action :set_device, only: [ :create ]

  def create
    @measurement = @device.measurements.build(measurement_params)
    respond_to do |format|
      if @measurement.save
        format.json { render json: { message: "Measurement saved correct", measurement: @measurement }, status: :created }
      else
        format.json { render json: { message: "Error saving measurement", errors: @measurement.errors }, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_device
      token=request.headers["Authorization"]&.split(" ")&.last
      @device=Device.find_by(api_key: token)
      unless @device
        render json: { error: "Incorrect Api token" }, status: :unauthorized and return
      end

    def measurement_params
      params.require(:measurement).permit(:temperature, :humidity)
    end
  end
end
