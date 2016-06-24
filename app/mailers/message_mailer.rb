class MessageMailer < ApplicationMailer
  def message_email(message)
    @message = message
    mail to: @message.user.email, subject: "コメントがありました。"
  end
end
