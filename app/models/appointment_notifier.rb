class AppointmentNotifier < ActionMailer::Base
  def new_appointment_email(params, user)
    subject "You have a new appontment request from PenwoodPartners.com"
    from "noreply@penwoodpartners.com"
    recipients AppConfig['email.internalrecipients']
    sent_on Time.now
    body :params => params, :user => user
  end  
end
