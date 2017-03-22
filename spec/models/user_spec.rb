require 'rails_helper'

describe User do
  it { should have_many(:passenger_bookings) }
  it { should have_many(:organisator_bookings) }
  it { should have_many(:trips) }
  it { should have_many(:passenger_trips) }
  it { should have_many(:notifications) }
end
