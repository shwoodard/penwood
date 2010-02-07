class ContactNotifier < ActionMailer::Base
  ActionMailer::Base.default_url_options[:host] = AppConfig['app.domain']
  
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
  
  def new_conversation_email(conversation, user)
    subject "Someone has included you in a new conversation at penwoodpartners.com"
    from "noreply@penwoodpartners.com"
    recipients user.email
    sent_on Time.now
    body :user => user, :conversation => conversation
  end
  
  def conversation_update_email(conversation, conversation_entry, user)
    subject "Someone has added to the conversation, #{conversation.subject}"
    from "noreply@penwoodpartners.com"
    recipients user.email
    sent_on Time.now
    body :user => user, :conversation => conversation, :conversation_entry => conversation_entry
  end
end
