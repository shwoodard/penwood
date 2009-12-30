class ActivationNotifier < ActionMailer::Base
  def activation_email(user)
    subject "Activate your account at penwoodpartners.com"
    from "noreply@penwoodpartners.com"
    recipients user.email
    sent_on Time.now
    body :user => user
  end
end
