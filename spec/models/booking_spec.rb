require 'rails_helper'

describe Booking do
  it { should belong_to(:user) }
  it { should belong_to(:trip) }
  it { should have_many(:notifications) }
  it { should validate_presence_of(:booking_guests) }
end
