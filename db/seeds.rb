puts "Destroying reviews"
Review.destroy_all
puts "Destroying bookings"
Booking.destroy_all
puts "Destroying trips"
Trip.destroy_all
puts "Destroying users"
User.destroy_all

puts "Creating Users"
User.create(
  email: 'helloworld@lewagon.com',
  password: "password",
  first_name: Faker::Name.first_name,
  last_name: Faker::Name.last_name,
  avatar_url: 'http://static.tvgcdn.net/mediabin/galleries/shows/s_z/si_sp/spongebob_squarepants/season1/sponge-bob-square-pants11.jpg',
  nickname: Faker::Pokemon.name + (1..100).to_a.sample.to_s,
  driving_licence: true,
  bio: Faker::Lorem.paragraph(3),
  birth_date: ((Date.new(1968,04,01))..(Date.new(1998,06,30))).to_a.sample,
)

5.times do
  print "."
  user = User.new(
    email: Faker::Internet.email,
    password: "password",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    avatar_url: 'http://static.tvgcdn.net/mediabin/galleries/shows/s_z/si_sp/spongebob_squarepants/season1/sponge-bob-square-pants11.jpg',
    nickname: Faker::Pokemon.name + (1..100).to_a.sample.to_s,
    driving_licence: true,
    bio: Faker::Lorem.paragraph(3),
    birth_date: ((Date.new(1968,04,01))..(Date.new(1998,06,30))).to_a.sample
  )
  user.save!
end

puts "Creating Destinations"

["Paris", "Marseille", "Lyon", "Monaco", "Santander", "Nice", "Madrid", "Barcelone", "Lisbonne", "Rome", "Milan", "Bordeaux", "Lille"].each do |location|
  print "."
  Destination.create(
  location: location
  )
end

puts "Creating Trips"

20.times do
  print "."
    start_date = ((Date.new(2017,04,01))..(Date.new(2017,06,30))).to_a.sample
    duration = (2..10).to_a.sample
    end_date = start_date + duration
    car = [true, false].sample
    car == true ? rental = 0 : rental = 50 * duration
    transportation = 30 * duration
    start_city_element = Destination.all.sample
    arrival_city_element = (Destination.all - [start_city_element]).sample
     trip = Trip.new(
  		title: ["Australia :Lovely tour", "Places to See in SF", "Beers to drink in california", "Queensland for EVER!", "Yosemite 2 days!", "Brokeback!", "Nevada ranches!", "Congo Forest : 3 night "].sample,
	    description: Faker::Lorem.paragraph(1),
			picture_urls: ['http://kingofwallpapers.com/landscape/landscape-199.jpg', 'http://kingofwallpapers.com/landscape/landscape-197.jpg', 'http://kingofwallpapers.com/landscape/landscape-203.jpg'].sample(3),
			start_date: start_date,
			arrival_date: end_date,
	    start_city: start_city_element.location,
	    arrival_city: arrival_city_element.location,
      has_car: car,
      rental_costs: rental,
	    transportation_costs: transportation,
      total_estimated_price: transportation + rental,
	    capacity: (1..4).to_a.sample,
	    min_passengers_required: (1..2).to_a.sample,
	    user_id: User.pluck(:id).sample,
  )
  trip.save!
  Step.create(
    trip_id: trip.id,
    destination_id: start_city_element.id,
    step_location: start_city_element.location
    )
  Step.create(
    trip_id: trip.id,
    destination_id: arrival_city_element.id,
    step_location: arrival_city_element.location
    )
  (0..4).to_a.sample.times do
    destination = (Destination.all - [start_city_element, arrival_city_element]).sample
    Step.create(
      trip_id: trip.id,
      destination_id: destination.id,
      step_location: destination.location
      )
  end
end

puts "Creating Bookings"

20.times do
  print "."
  trip_id = Trip.pluck(:id).sample
  booking_guests = (1..3).to_a.sample
	booking = Booking.new(
	  booking_guests: booking_guests,
	  booking_price: Trip.find_by_id(trip_id).total_estimated_price / (Trip.find_by_id(trip_id).min_passengers_required + 1 ) * booking_guests,
	  user_id: User.pluck(:id).sample,
	  trip_id: trip_id,
    motivation_message: "hello, this is my motivation message blablablabla"
    )
  booking.save!
end


puts "Creating Reviews"
20.times do
  print "."
	review = Review.new(
	  description: Faker::Lorem.paragraph(2),
	  rating: (1..5).to_a.sample,
	  best_picture_url: 'http://kingofwallpapers.com/landscape/landscape-203.jpg',
	  user_id: User.pluck(:id).sample,
	  trip_id: Trip.pluck(:id).sample,
    )
  review.save!
end


puts "Creating Old Trips"
5.times do
  print "."
    start_date = ((Date.new(2016,04,01))..(Date.new(2016,06,30))).to_a.sample
    duration = (2..10).to_a.sample
    end_date = start_date + duration
    car = [true, false].sample
    car == true ? rental = 0 : rental = 50 * duration
    transportation = 30 * duration
    start_city_element = Destination.all.sample
    arrival_city_element = (Destination.all - [start_city_element]).sample
    trip = Trip.new(
      title: ["Australia :Lovely tour", "Places to See in SF", "Beers to drink in california", "Queensland for EVER!", "Yosemite 2 days!", "Brokeback!", "Nevada ranches!", "Congo Forest : 3 night "].sample,
      description: Faker::Lorem.paragraph(1),
      picture_urls: ['http://kingofwallpapers.com/landscape/landscape-199.jpg', 'http://kingofwallpapers.com/landscape/landscape-197.jpg', 'http://kingofwallpapers.com/landscape/landscape-203.jpg'].sample(3),
      start_date: start_date,
      arrival_date: end_date,
      start_city: start_city_element.location,
      arrival_city: arrival_city_element.location,
      has_car: car,
      rental_costs: rental,
      transportation_costs: transportation,
      total_estimated_price: transportation + rental,
      capacity: (1..4).to_a.sample,
      min_passengers_required: (1..2).to_a.sample,
      user_id: User.first(2).sample.id
  )
  trip.save!
  Step.create(
    trip_id: trip.id,
    destination_id: start_city_element.id,
    step_location: start_city_element.location
    )
  Step.create(
    trip_id: trip.id,
    destination_id: arrival_city_element.id,
    step_location: arrival_city_element.location
    )
  (0..4).to_a.sample.times do
    destination = (Destination.all - [start_city_element, arrival_city_element]).sample
    Step.create(
      trip_id: trip.id,
      destination_id: destination.id,
      step_location: destination.location
      )
  end
end

puts "Creating old Bookings"
5.times do
  print "."
  trip = Trip.last(5).sample
  booking_guests = (1..2).to_a.sample
  booking = Booking.new(
    booking_guests: booking_guests,
    booking_price: trip.total_estimated_price / (trip.min_passengers_required + 1 ) * booking_guests,
    user_id: [User.all[2], User.all[3]].sample.id,
    trip_id: trip.id,
    motivation_message: "hello, this is my motivation message blablablabla"
    )
  booking.save!
end

puts "Well done !!! dude "

# ['https://unsplash.com/?photo=3yzE1SUfbwY','https://unsplash.com/?photo=jP_NwopKN9k','https://unsplash.com/collections/curated/136?photo=AaExF6NxvQo','https://unsplash.com/collections/curated/136?photo=_fYBsiQzMHI','https://unsplash.com/collections/curated/136?photo=S5i0ovZbMRQ','https://unsplash.com/?photo=QwDKn5u6p2I', 'https://unsplash.com/?photo=ZMS5PPn_zEo', 'https://unsplash.com/?photo=emZus7dBLIw', 'https://unsplash.com/?photo=mGYxAWITqMg', 'https://unsplash.com/?photo=8peGuud5cEw', 'https://unsplash.com/?photo=1GrhuyHfzsI', 'https://unsplash.com/?photo=1GrhuyHfzsI'].sample,
