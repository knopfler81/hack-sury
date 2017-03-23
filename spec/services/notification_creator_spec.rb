require 'rails_helper'
### A REVOIR
describe NotificationCreator do

  describe '#notify_organisator' do
    it 'notifies the organisator' do
      passenger = create(:user, id: 10, first_name: 'Paul', last_name: 'Michel', email: 'paul@michel.net')
      organisator = create(:user)

      trip = create(:trip, title: 'Coolitos', user: organisator)

      booking = create(:booking, user: passenger, trip: trip)
      booking.payment

      notif = NotificationCreator.new(booking).notify_organisator

      notification = create(
        :notification,
        user: organisator,
        topic: booking,
        content: "#{booking.user.first_name} #{booking.user.last_name} has booked your trip #{booking.trip.title}."
      )
      expect(notif.user).to eq(notification.user)
      expect(notif.topic).to eq(notification.topic)
      expect(notif.content).to eq(notification.content)
    end
  end

  describe '#notify_other_passengers' do
    it 'notifies other passengers that someone also joined the trip' do
      passenger1 = create(:user, id: 10, first_name: 'Paul', last_name: 'Michel', email: 'paul@michel.net')
      passenger2 = create(:user, id: 11, first_name: 'Berthe', last_name: 'Michel', email: 'berthe@michel.net')
      passenger3 = create(:user, id: 12, first_name: 'Liliane', last_name: 'Michel', email: 'liliane@michel.net')
      passenger4 = create(:user, id: 13, first_name: 'Marie', last_name: 'Michel', email: 'marie@michel.net')

      organisator = create(:user)
      trip = create(:trip, title: 'Coolitos', user: organisator)

      booking1 = create(:booking, user: passenger1, trip: trip, payment_status: true)
      booking2 = create(:booking, user: passenger2, trip: trip, payment_status: true)
      booking3 = create(:booking, user: passenger3, trip: trip, payment_status: true)

      booking4 = create(:booking, user: passenger4, trip: trip)
      booking4.payment

      notifications = NotificationCreator.new(booking4).notify_other_passengers

      expect(notifications.size).to eq(4)
    end
  end

  describe '#notify_trip_confirmation_for_passengers' do
    it 'notifies passengers when the the trip is confirmed' do
      trip = create(:trip, title: 'Coolitos', min_passengers_required: 3)

      passenger1 = create(:user, id: 10, first_name: 'Paul', last_name: 'Michel', email: 'paul@michel.net')
      booking1 = create(:booking, user: passenger1, trip: trip, payment_status: true, booking_guests: 3)
      passenger2 = create(:user, id: 11, first_name: 'Jamie', last_name: 'Michel', email: 'jamie@michel.net')
      booking2 = create(:booking, user: passenger2, trip: trip, payment_status: true, booking_guests: 1)

      notifications_conf_passengers = NotificationCreator.new(booking1).notify_trip_confirmation_for_passengers

      expect(notifications_conf_passengers.size).to eq(2)
    end
    it 'does not notify passengers when the the trip is not confirmed' do
      trip = create(:trip, title: 'Coolitos', min_passengers_required: 3)

      passenger1 = create(:user, id: 10, first_name: 'Paul', last_name: 'Michel', email: 'paul@michel.net')
      booking1 = create(:booking, user: passenger1, trip: trip, payment_status: true, booking_guests: 1)
      passenger2 = create(:user, id: 11, first_name: 'Jamie', last_name: 'Michel', email: 'jamie@michel.net')
      booking2 = create(:booking, user: passenger2, trip: trip, payment_status: true, booking_guests: 1)

      notifications_conf_passengers = NotificationCreator.new(booking1).notify_trip_confirmation_for_passengers

      expect(notifications_conf_passengers.size).to eq(2)
    end
  end

  describe '#notify_trip_confirmation_for_organisator' do
    it 'notifies organisator when the trip is confirmed' do
      organisator = create(:user)
      trip = create(:trip, title: 'Coolitos', user: organisator, confirmed: true)
      booking = create(:booking, trip: trip)

      notif = NotificationCreator.new(booking).notify_trip_confirmation_for_organisator

      notification = create(
        :notification,
        user: organisator,
        topic: booking,
        content: "Congratulations, #{booking.trip.title} is confirmed, get ready for #{booking.trip.start_date}."
      )
      expect(notif.user).to eq(notification.user)
      expect(notif.topic).to eq(notification.topic)
      expect(notif.content).to eq(notification.content)
    end
    # it 'does not notify organisator when the trip is not confirmed' do
    #   organisator = create(:user)
    #   trip = create(:trip, title: 'Coolitos', user: organisator, confirmed: false)
    #   booking = create(:booking, trip: trip, booking_guests: 1)

    #   plop = NotificationCreator.new(booking).notify_trip_confirmation_for_organisator

    #   expect(plop).to be_blank
    # end
  end
end
