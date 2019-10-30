class UserEmailMailer < ApplicationMailer
  default from: 'from@example.com'

  def send_notify(user_id,action)
    @user = User.find user_id
    @action = action
    mail(:to => @user.email,:subject => t("mailer.#{@action}"))
  end

end
