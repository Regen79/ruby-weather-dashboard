class Device < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
  has_secure_token :api_key
  has_many :measurements, dependent: :destroy
end
