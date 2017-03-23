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

        mail(
          to:       booking.user.email,
          subject:  "Readdy to go ! to Trip #{@trip.trip.arrival_city} is confirmed!"
        )
      end
  end

  def trip_confirmation_driver(trip)
    @trip = trip

        mail(
          to:       @trip.user.email,
          subject:  "Your Trip to #{@trip.trip.arrival_city} is confirmed!"
        )
  end

end
