class NotificationCreatorRefacto
  def initialize(booking)
  # voir si possible de mettre soit le booking (method1), soit le trip (method2)
  # hash ?
    @booking = booking
    @trip = @booking.trip
    @organisator = @booking.trip.user
    @trip_bookings = @booking.trip.bookings
    @passenger = @booking.user
  end

  def notify_related_users
    notify_organisator # method1: when someone booked
    notify_other_passengers # method1
    if @trip.confirmed? # method2: when trip is confirmed (Trip model?)
      notify_trip_confirmation_for_organisator
      notify_trip_confirmation_for_passengers
    end
  end

  def notify_organisator
    Notification.create(
      user: @organisator,
      topic: @booking,
      content: "#{@passenger.first_name} #{@passenger.last_name}
        has booked your trip #{@trip.title}."
    )
  end

  def notify_other_passengers
    @trip_bookings.each do |booking|
      if booking.user != @passenger
        Notification.create(
          user: booking.user,
          topic: @booking,
          content: "#{@passenger.first_name} #{@passenger.last_name}
            has also joined #{@trip.title}."
        )
      end
    end
  end

  def notify_trip_confirmation_for_passengers
    @trip_bookings.each do |booking|
      Notification.create(
        user: booking.user,
        topic: @booking,
        content: "#{@trip.title} is confirmed,
          get ready for #{@trip.start_date}."
      )
    end
  end

  def notify_trip_confirmation_for_organisator
    Notification.create(
      user: @organisator,
      topic: @booking,
      content: "Congratulations, #{@trip.title} is confirmed,
        get ready for #{@trip.start_date}."
    )
  end
end
