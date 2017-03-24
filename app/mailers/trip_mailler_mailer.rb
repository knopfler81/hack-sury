class TripMaillerMailer < ApplicationMailer
  default from: 'trip_team@easytrip.com'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.trip_mailler_mailer.creation_confirmation.subject
  #
  def creation_confirmation(trip)
    @trip = trip

        mail(
          to:       @trip.user.email,
          subject:  " Your Trip #{@trip.title} created!"
        )
  end

  def trip_confirmation_passagers(trip)
    @trip = trip

    @trip.bookings.each do |booking|
      @user = booking.user
        mail(
          to:       booking.user.email,
          subject:  "Readdy to go ! to Trip #{@trip.arrival_city} is confirmed!"
        )
      end
  end

  def trip_confirmation_driver(trip)
    @trip = trip

        mail(
          to:       @trip.user.email,
          subject:  "Your Trip to #{@trip.arrival_city} is confirmed!"
        )
  end

  def send_message_to_driver(driver, message_content, sender, trip)
    @message_content = message_content
    @driver = driver
    @sender = sender
    @trip = trip

    mail(to: @driver.email, subject: "You received a new message from #{@sender.first_name} about #{@trip.title}")
  end
end
