class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  has_many :devices, dependent: :destroy
  normalizes :email_address, with: ->(e) { e.strip.downcase }
  validates :email_address, presence: true, uniqueness: true
  validates :password, length: { minimum: 10 }, if: -> { password.present? }
  validates :password, format: {
    with: /(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*\W)/,
    message: "must include at least one lowercase letter, one uppercase letter, digit,  and one special character"
  }, if: -> { password.present? }
  generates_token_for :email_verification, expires_in: 2.days do
    email_address
  end
end
