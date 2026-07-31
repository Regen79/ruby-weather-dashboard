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
end
