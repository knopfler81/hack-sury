class BookingMaillerMailer < ApplicationMailer
  default from: 'booking_team@easytrip.com'
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.booking_mailler_mailer.booking_confirmation.subject
  #
  def booking_confirmation(booking)
    @booking = booking

        mail(
          to:       @booking.user.email,
          subject:  "Well done ! you re going to  #{@booking.trip.arrival_city}!"
        )
  end

  def booking_driver_confirmation(booking)
    @booking = booking

        mail(
          to:       @booking.trip.user.email,
          subject:  "Good job !one more passenger : #{@booking.user.first_name}!"
        )
  end
end
