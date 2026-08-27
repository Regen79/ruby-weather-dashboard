module User::Validations
    extend ActiveSupport::Concern
    included do
        validates :email_address, presence: true, uniqueness: true
        validates :password, length: { minimum: 10 }, if: -> { password.present? }
        validates :password, format: {
            with: /\A(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*\W).*\z/,
            message: "must include at least one lowercase letter, one uppercase letter, digit,  and one special character"
        }, if: -> { password.present? }
    end
end
