class Measurement < ApplicationRecord
  belongs_to :device

  validates :temperature, presence: true, numericality: {
    greater_than_or_equal_to: -100,
    less_than_or_equal_to: 60
  }
  validates :humidity, presence: true, numericality: {
    greater_than_or_equal_to: 0,
    less_than_or_equal_to: 100
  }

  scope :for_day, ->(date) {
    where(created_at: date.beginning_of_day..date.end_of_day)
  }


  def self.sampled_for_day(date, max_points)
    daily_measurements = for_day(date)
    total_count = daily_measurements.count

    if total_count > max_points
      step = total_count.to_f / max_points
      indexes = (0...total_count).step(step).map(&:to_i)
      daily_measurements.to_a.values_at(*indexes).compact
    else
      daily_measurements.to_a
    end
  end
end
