class UserMailer < ApplicationMailer
  def welcome(user)
    @user = user  # Instance variable => available in view

    mail(to: @user.email, subject: 'Welcome to EasyTrip !')
    # This will render a view in `app/views/user_mailer`!
  end

  def send_message(driver, message_content, sender, trip)
    @message_content = message_content
    @driver = driver
    @sender = sender
    @trip = trip

    mail(to: @driver.email, subject: "You received a new message from #{@sender.first_name} about #{@trip.title}")
  end
end
