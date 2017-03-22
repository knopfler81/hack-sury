class TripMaillerMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.trip_mailler_mailer.creation_confirmation.subject
  #
  def creation_confirmation(trip)
    @trip = trip

        mail(
          to:       @trip.user.email,
          subject:  "Trip #{@trip.title} created!"
        )
  end
end
