class UserMailer < ApplicationMailer
  def verification(user)
    @user = user
    @token = user.generate_token_for(:email_verification)
    
    # Create verification link
    verification_url = edit_email_verification_url(token: @token)

    # Fetch Brevo API key from credentials
    api_key = Rails.application.credentials.dig(:brevo, :api_key)

    api_instance = Brevo::TransactionalEmailsApi.new
    api_instance.api_client.config.api_key['api-key'] = api_key

    send_smtp_email = Brevo::SendSmtpEmail.new(
      sender: { email: "krzysztofmurias02@gmail.com", name: "Weather Dashboard" },
      to: [{ email: @user.email_address }],
      subject: "Activate your account",
      html_content: "<p>Hello!</p><p>Click the link below to activate your account:</p><p><a href='#{verification_url}'>Activate account</a></p>"
    )

    begin
      api_instance.send_transac_email(send_smtp_email)
    rescue Brevo::ApiError => e
      Rails.logger.error("Error sending verification email via Brevo API: #{e}")
    end
  end
end