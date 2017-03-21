class UsersController < ApplicationController

  def show
    @review = Review.new
    @user = User.find(params[:id])

    if current_user.completed_profile?
      @trip = Trip.new
      @destination = Destination.new
      @step = Step.new
    else
      redirect_to edit_user_registration_path, notice: 'Please complete your profile to organize a trip.'
    end
    # @trips = @user.trips
    # @passed_passenger_trips   = @user.passed_trips_as_passenger
    # @passed_organisator_trips = @user.passed_trips_as_organisator
    # @upcoming_passenger_trips = @user.upcoming_trips_as_passenger
    # @passenger_motivations    = @user.motivations
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :nickname, :avatar, :email, :birth_date, :bio, :driving_licence, :password, :password_confirmtaion, :current_password)
  end

end
    # passenger_bookings.trip.select {|trip| trip.where('confirmed = ?', true) }
