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
  end

  # POST /users/:user_id/send_message
  def send_message
    # params -> message: "user message"
    # user_send_message
    @user = User.find(params[:user_id])

    UserMailer.send_message(@user, params[:message]).deliver_now
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :nickname, :avatar, :email, :birth_date, :bio, :driving_licence, :password, :password_confirmtaion, :current_password)
  end

end
    # passenger_bookings.trip.select {|trip| trip.where('confirmed = ?', true) }
