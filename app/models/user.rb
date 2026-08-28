class User < ApplicationRecord
  include User::Validations
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :devices, dependent: :destroy
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  generates_token_for :email_verification, expires_in: 2.days do
    email_address
  end
end
