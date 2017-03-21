class BookingsController < ApplicationController
  before_action :find_booking, only: [:show, :update, :pay]
  before_action :find_trip, only: [:create]


  def show
    @trip = @booking.trip
  end

  def create
    if current_user == nil
      redirect_to new_user_registration_path
    else
      if current_user.completed_profile?
        @booking = Booking.new(booking_params)
        @booking.user = current_user
        @booking.trip = @trip
        if @booking.save
          redirect_to booking_path(@booking)
        else
          redirect_to trip_path(@trip)
        end
      else
        session[:redirect_to] = trip_path(@trip)
        redirect_to edit_user_registration_path, notice: 'Please complete your profile to book a trip.'
      end
    end
  end

  def update
    if @booking.update(booking_params)
      respond_to do |format|
        format.html { redirect_to booking_path(@booking), notice: "Payment succeed" }
        format.js   # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      redirect_to @booking, error: "Payment failed"
    end
  end

  # def pay
  #   @booking.update(motivation_message: params[:booking][:motivation_message])
  #   @booking.payment
  #   NotificationCreator.new(@booking).notify_related_users
  # end

  private

  def find_booking
    @booking = Booking.find(params[:id])
  end

  def find_trip
    @trip = Trip.find(params[:trip_id])
  end

  def booking_params
    params.require(:booking).permit(:booking_guests, :booking_price, :payment_status, :motivation_message)
  end
end
