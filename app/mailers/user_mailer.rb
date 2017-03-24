class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user  # Instance variable => available in view

    mail(to: @user.email, subject: 'Welcome to EasyTrip !')
    # This will render a view in `app/views/user_mailer`!
  end

  def send_message(user, message_content)
    @message_content = message_content
    @user = user

    mail(to: @user.email, subject: 'You received a new message')
  end
end
