require 'rails_helper'


describe Trip do
  it { should belong_to(:user) }
  it { should have_many(:reviews) }
  it { should have_many(:bookings) }
  it { should have_many(:notifications) }
  it { should have_many(:steps) }
  it { should have_many(:destinations) }

  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:start_date) }
  it { should validate_presence_of(:start_city) }
  it { should validate_presence_of(:arrival_date) }
  it { should validate_presence_of(:arrival_city) }
  it { should validate_presence_of(:total_estimated_price) }


  describe '.passed' do
    it 'returns only passed trips' do
      trip_passed = create(:trip, start_date: 3.days.ago)
      trip_coming = create(:trip, start_date: 5.days.from_now)

      passed_trip = Trip.passed

      expect(passed_trip.size).to eq(1)
      expect(passed_trip.first).to eq(trip_passed)

    end
  end

  describe '.coming' do
    it 'returns only coming trips' do
      trip_passed = create(:trip, start_date: 3.days.ago)
      trip_coming = create(:trip, start_date: 5.days.from_now)

      coming_trip = Trip.coming

      expect(coming_trip.size).to eq(1)
      expect(coming_trip.first).to eq(trip_coming)

    end
  end

  describe '#passed?' do
    it 'returns true if arrival date is in the past' do
      trip = create(:trip, arrival_date: 3.days.ago)

      expect(trip).to be_passed
    end

    it 'returns false if arrival date is in the future' do
      trip = create(:trip, arrival_date: 3.days.from_now)

      expect(trip).not_to be_passed
    end
  end

  describe '.all_without_past_trips' do
    it 'returns all upcoming trips ' do
      upcoming_trip = create(:trip, start_date: (Date.today || 3.days.ago))

      trip_upcoming = Trip.all_without_past_trips

      expect(trip_upcoming.size).to eq(1)
      expect(trip_upcoming.first).to eq(upcoming_trip)

    end
  end

  describe '#update_confirmed_field' do
    it "update confirmed fields" do
      trip = build(:trip, confirmed: false, min_passengers_required: 2)
      booking = build(:booking, booking_guests: 2, trip: trip)

      expect(trip.min_passengers_required).to eq(booking.booking_guests)

    end
  end

  describe "#available_seats" do
    it "returns available seats" do
      trip = create(:trip, capacity: 4)
      booking = create(:booking, booking_guests: 2)

      expect(trip.capacity && booking.booking_guests).to eq(2)
    end
  end


end
