class MeasurementsController < ApplicationController
  before_action :set_device, only: [ :index ]

  # GET /measurements or /measurements.json
  def index
    @measurements = @device.measurements

    respond_to do |format|
      format.html
      format.json { render json: @measurements }
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_device
      @device = Current.user.devices.find(params[:device_id])
    end
end
