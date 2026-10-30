class UserMailer < ApplicationMailer
  def verification(user)
    @user = user
    @token=user.generate_token_for(:email_verification)
    mail subject: "Activate your account", to: user.email_address
  end
end
