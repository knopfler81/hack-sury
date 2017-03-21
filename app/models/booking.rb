class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :trip
  has_many :notifications, as: :topic

  monetize :booking_price_cents, :as => "booking_price"

  validates :booking_guests, presence: true
  before_save :calculate_booking_price
  def payment
    self.payment_status = true
    self.save
    trip.update_confirmed_field
  end

  def calculate_booking_price
    price_per_person = 0.25 * (trip.total_estimated_price / (trip.min_passengers_required + 1))
    self.booking_price = price_per_person * booking_guests
  end


  # Pour le refacto de malade dans le modèle trip
  # Custom finder, Like Booking.all but called using Booking.payed
  # It returns only payed booking (because of the condition inside)
  def self.payed
    where(payment_status: true)
  end
end
