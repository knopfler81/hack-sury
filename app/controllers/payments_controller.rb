class PaymentsController < ApplicationController
  before_action :set_booking

  def create
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail]
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       @booking.booking_price_cents, # or booking_price_pennies
      description:  "Payment for trip #{@booking.trip.title} for booking #{@booking.id}",
      currency:     @booking.booking_price.currency
    )

    @booking.update(payment: charge.to_json)
    @booking.payment
    NotificationCreator.new(@booking).notify_related_users


    redirect_to user_path(current_user), notice: "Your payment was successfull :)"

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_booking_payment_path(@booking)
  end

  private

  def set_booking
    @booking = Booking.where(payment_status: false).find(params[:booking_id])
  end
end
