class InquiryMailer < ApplicationMailer
  def inquiry_email(inquiry)
    @inquiry = inquiry
    mail to: inquiry.email, subject: "お問い合わせありがとうございます", bcc: "sample@example.com"
  end
end