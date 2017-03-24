class TripsController < ApplicationController
  def index
    @trips = Trip.all_without_past_trips

    filter_trips if params[:query].present?
    # @trips = Trip.near('Monaco', 1000)

    @trips_cities = @trips.map do |trip|
      { start: trip.start_city, end: trip.arrival_city }
    end

    @trips.each do |trip|
      @start_lat = trip.steps.find_by_step_location(trip.start_city).destination.latitude
      @start_long = trip.steps.find_by_step_location(trip.start_city).destination.longitude
      @last_lat = trip.steps.find_by_step_location(trip.arrival_city).destination.latitude
      @last_long = trip.steps.find_by_step_location(trip.arrival_city).destination.longitude
      # steps = trip.steps - [trip.steps.find_by_step_location(trip.start_city), trip.steps.find_by_step_location(trip.arrival_city)]
      # @step = step.first.destination.latitude + ',' + step.first.destination.longitude
      # steps_array = steps.map do |step|
      #   {location: step.step_location, stopover: true}
      # end
      # marker.lat trip.start_lat
      # marker.lng trip.start_long
    end
  end

  def show
    @trip = Trip.find(params[:id])
    latlong_departure
    latlong_arrival
    latlong_steps
    @booking = Booking.new
    @trip_cities = [{ start: @trip.start_city, end: @trip.arrival_city }]
    # @hash = Gmaps4rails.build_markers(@trip) do |trip, marker|
    #   marker.lat trip.start_lat
    #   marker.lng trip.start_long
    # end
  end

  def new
    if current_user == nil
      redirect_to new_user_registration_path
    else
      if current_user.completed_profile?
        @trip = Trip.new
        @destination = Destination.new
        @step = Step.new
      else
        redirect_to edit_user_registration_path, notice: 'Please complete your profile to organize a trip.'
      end
    end
  end

  def create
    if current_user == nil
      redirect_to new_user_registration_path
    else
      @trip = Trip.new(trip_params)
      @trip.user = current_user
      @trip.total_estimated_price! # pour initialiser le total estimated price
      if @trip.save
        TripMaillerMailer.creation_confirmation(@trip).deliver_now
        @start_location = Destination.find_or_create_by(location: @trip.start_city)
        @last_location = Destination.find_or_create_by(location: @trip.arrival_city)
        @trip.steps.create(destination: @start_location, step_location: params[:trip][:start_city])
        @trip.steps.create(destination: @last_location, step_location: params[:trip][:arrival_city])
        redirect_to trip_path(@trip)
      else
        render :new
      end
    end
  end

  def edit
    @trip = Trip.find(params[:id])
  end

  def update # Pas comme create??
    @trip = Trip.find(params[:id])
    @trip.total_estimated_price! # pour initialiser le total estimated price
    if @trip.update(trip_params)
      redirect_to trip_path(@trip)
    else
      render :edit
    end
  end

  def destroy
    @trip = Trip.find(params[:id])
    @trip.destroy
    redirect_to my_profile_path
  end


  def send_message_to_driver
    # params -> message: "user message"
    # user_send_message
    @trip = Trip.find(params[:trip_id])
    @driver = @trip.user
    @sender = current_user

    UserMailer.send_message(@driver, params[:message], @sender, @trip).deliver_now
    redirect_to trip_path(@trip)
  end

  private


  def trip_params
    params
      .require(:trip)
      .permit(
        :title,
        :description,
        :start_city,
        :start_date,
        :arrival_city,
        :arrival_date,
        :has_car,
        :transportation_costs,
        :rental_costs,
        :min_passengers_required,
        :flexible,
        :guests,
        :capacity,
        pictures: [],
        steps_attributes: [:step_location, :_destroy]
      )
  end

  def filter_trips
    #trip aux alentours.
    @trips = @trips.near(params[:query][:start_city], 10) if params[:query][:start_city].present?

    #Condition si flexible
    if params[:query][:start_date].present?
      if params[:query][:date_flexible] == '1'
        @trips =
          @trips.where(
          'start_date >= ? AND start_date <= ?',
            Date.parse(params[:query][:start_date]) - 3.days,
            Date.parse(params[:query][:start_date]) + 3.days,
          )
      else
        @trips = @trips.where('start_date = ?', params[:query][:start_date])
      end
    end

    #trip en fonction des places disponibles.
    if params[:query][:guests].present?
      @trips = @trips.select { |trip| trip.available_seats >= params[:query][:guests].to_i }
    end
  end

  def latlong_departure
    @start_lat = @trip.steps.find_by_step_location(@trip.start_city).destination.latitude
    @start_long = @trip.steps.find_by_step_location(@trip.start_city).destination.longitude
  end

  def latlong_arrival
    @last_lat = @trip.steps.find_by_step_location(@trip.arrival_city).destination.latitude
    @last_long = @trip.steps.find_by_step_location(@trip.arrival_city).destination.longitude
  end

  def latlong_steps
    @steps = @trip.steps - [@trip.steps.find_by_step_location(@trip.start_city), @trip.steps.find_by_step_location(@trip.arrival_city)]
    # @step = step.first.destination.latitude + ',' + step.first.destination.longitude
    @steps_array = @steps.map do |step|
      {location: step.step_location, stopover: true}
    end
  end

  def set_total_estimated_price
    if @trip.has_car?
      @trip.total_estimated_price = @trip.transportation_costs
    else
      @trip.total_estimated_price = @trip.transportation_costs + @trip.rental_costs
    end
  end
end
