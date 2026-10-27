class PasswordsMailer < ApplicationMailer
  def reset(user)
    @user = user
    from_address = Rails.application.credentials.dig(:smtp, :user_name) 
    mail subject: "Reset your password", to: user.email_address, from: from_address
  end
end


