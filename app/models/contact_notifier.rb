class ContactNotifier < ActionMailer::Base
  def new_user_email(user)
    subject "You have a new signup at penwoodpartners.com"
    from "noreply@penwoodpartners.com"
    recipients AppConfig['email.internalrecipients']
    sent_on Time.now
    body :user => user
  end

  def new_contact_email(contact)
    subject "Someone filled out the contact form at penwoodpartners.com"
    from "noreply@penwoodpartners.com"
    recipients AppConfig['email.internalrecipients']
    sent_on Time.now
    body :contact => contact
  end
end
