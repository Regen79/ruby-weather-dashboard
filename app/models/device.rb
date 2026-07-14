class Device < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
  has_many :measurements, dependent: :destroy
end
