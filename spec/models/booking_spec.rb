require 'rails_helper'

describe Booking do
  it { should belong_to(:user) }
  it { should belong_to(:trip) }
  it { should have_many(:notifications) }
  it { should validate_presence_of(:booking_guests) }

  describe 'booking_price field' do
    it 'is monetized' do
      is_expected.to monetize(:booking_price_cents).as(:booking_price)
    end
  end

  describe '.payed' do
    it 'returns only payed booking' do
      booking_payed = create(:booking, payment_status: true)
      booking_unpayed = create(:booking, payment_status: false)

      payed_bookings = Booking.payed

      expect(payed_bookings.size).to eq(1)
      expect(payed_bookings.first).to eq(booking_payed)
    end
  end

  describe '#calculate_booking_price' do
    it 'is called on a before save' do
      trip = create(:trip, total_estimated_price: 300, min_passengers_required: 2)
      booking = build(:booking, booking_guests: 2, trip: trip)

      booking.save

      expect(booking.booking_price.to_i).to eq(50)
    end
  end

  describe '#payment' do
    it 'sets payments status to true' do
      booking = build(:booking, payment_status: false)

      booking.payment

      expect(booking.payment_status).to be_truthy
    end

    it 'calls update_confirmed_field on related trip' do
      booking = build(:booking)
      trip = booking.trip
      allow(trip).to receive(:update_confirmed_field)

      booking.payment

      expect(trip).to have_received(:update_confirmed_field)
    end
  end
end
