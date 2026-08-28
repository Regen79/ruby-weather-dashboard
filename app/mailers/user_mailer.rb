class UserMailer < ApplicationMailer
  def verification(user)
    @user = user
    @token=user.generate_token_for(:email_verification)
    mail subject: "Active your account", to: user.email_address, from: "Support@weatherdashboard.com"
  end
end
