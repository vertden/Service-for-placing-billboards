class SendNotificationJob < ApplicationJob
  queue_as :default

  def perform(*args,user_id,action)
    # Do something later
    UserEmailMailer.send_notify(user_id,action).deliver
  end
end
