class UserMailer < ApplicationMailer

  def photo_approved
    email = params[:email]
    attachments.inline['image.jpg'] = File.read(params[:image])
    mail(to: email, subject: 'photo approved')
  end
end
