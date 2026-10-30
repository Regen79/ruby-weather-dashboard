class ApplicationMailer < ActionMailer::Base
  default from: email_address_with_name("noreply@crislabs.com", "Weather Dashboard")
    reply_to: "contact@crislabs.com"
  layout "mailer"
end
