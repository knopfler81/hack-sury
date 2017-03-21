class NotificationCreator
  def initialize(booking)
    @booking = booking
  end

  def notify_related_users
    notify_organisator
    notify_other_passengers
    if @booking.trip.confirmed?
      notify_trip_confirmation_for_organisator
      notify_trip_confirmation_for_passengers
    end
  end

  private

  def notify_organisator
    Notification.create(
      user: @booking.trip.user,
      topic: @booking,
      content: "#{@booking.user.first_name} #{@booking.user.last_name} has booked your trip #{@booking.trip.title}."
    )
  end

  def notify_other_passengers
    @booking.trip.bookings.each do |booking|
      if booking.user != @booking.user
        Notification.create(
          user: booking.user,
          topic: @booking,
          content: "#{@booking.user.first_name} #{@booking.user.last_name} has also joined #{@booking.trip.title}."
        )
      end
    end
  end

  def notify_trip_confirmation_for_passengers
    @booking.trip.bookings.each do |booking|
      Notification.create(
        user: booking.user,
        topic: @booking,
        content: "#{@booking.trip.title} is confirmed, get ready for #{@booking.trip.start_date}."
      )
    end
  end

  def notify_trip_confirmation_for_organisator
    Notification.create(
      user: @booking.trip.user,
      topic: @booking,
      content: "Congratulations, #{@booking.trip.title} is confirmed, get ready for #{@booking.trip.start_date}."
    )
  end
end
