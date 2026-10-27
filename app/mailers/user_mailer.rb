class UserMailer < ApplicationMailer
  def verification(user)
    @user = user
    @token=user.generate_token_for(:email_verification)
    from_address = Rails.application.credentials.dig(:smtp, :user_name)
    mail subject: "Active your account", to: user.email_address, from: from_address
  end
end
