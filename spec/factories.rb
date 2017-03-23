FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "#{n}.#{Faker::Internet.email}" }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    nickname { Faker::Internet.user_name }
    driving_licence false
    bio { Faker::HarryPotter.quote }
    admin false
    birth_date 20.years.ago
    password 'password'
    #avatar { File.new(Rails.root.join('app', 'assets', 'images', 'logo.png')) }
  end

  factory :booking do
    booking_guests 3
    payment_status false
    user
    trip
    motivation_message { Faker::ChuckNorris.fact }
  end

  factory :trip do
    title { Faker::Hipster.sentence(3) }
    description { Faker::Hipster.paragraph(2) }
    start_city 'Los Angeles'
    arrival_city 'Las Vegas'
    start_date 3.days.from_now
    arrival_date 5.days.from_now
    flexible true
    total_estimated_price 2_000
    capacity 5
    min_passengers_required 4
    user
    has_car false
    transportation_costs 300
    rental_costs 200
  end

  factory :notification do
    read false
    content 'notification content'
    user
    association :topic, factory: :booking
  end
end
