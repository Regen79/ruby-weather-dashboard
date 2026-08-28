class MeasurementsController < ApplicationController
  before_action :set_device
  before_action :set_measurement, only: [ :show, :edit, :update, :destroy ]

  # GET /measurements or /measurements.json
  def index
    @measurements = @device.measurements
    if params[:day].present?
      selected_day=Date.parse(params[:day])
    else
      selected_day=Date.current
    end
    @daily_measurements = @device.measurements.where(created_at: selected_day.beginning_of_day..selected_day.end_of_day)
    max_points = 20
    total_count = @daily_measurements.count
    if total_count > max_points
      step = total_count.to_f / max_points
      indexes = (0...total_count).step(step).map(&:to_i)
      @filtered_measurements = @daily_measurements.to_a.values_at(*indexes).compact
    else
      @filtered_measurements = @daily_measurements.to_a
    end

    @monthly_temperatures=@device.measurements.group_by_month(:created_at, format: "%B").average(:temperature)
    @monthly_humidities=@device.measurements.group_by_month(:created_at, format: "%B").average(:humidity)

    respond_to do |format|
      format.html
      format.json { render json: @measurements }
    end
  end

  def show
  end


  # GET /devices/1/edit
  def edit
  end

  # PATCH/PUT /devices/1 or /devices/1.json
  def update
    respond_to do |format|
      if @measurement.update(measurement_params)
        format.html { redirect_to device_measurement_path(@device, @measurement), notice: "Measurement was successfully updated.", status: :see_other }
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
