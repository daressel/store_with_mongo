class ConfirmRegistrationMailer < ApplicationMailer
  def notify_user(user)
    @user = user
    mail(to: user.email, subject: 'Confirm registration')
  end
end
