class TestEmailMailer < ApplicationMailer
  def notify_user(mail)
    # @user = user
    # mail(to: @user.email, subject: 'welcome')
    mail(to: mail, subject: 'welcome')
  end
end
