class Trip < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :bookings

  has_many :notifications, as: :topic

  has_many :steps, dependent: :destroy
  has_many :destinations, through: :steps
  accepts_nested_attributes_for :steps, reject_if: :all_blank, allow_destroy: true


  has_attachments :pictures, maximum: 10

  validates :title, :start_date, :start_city, :arrival_date, :arrival_city, presence: true
  validates :total_estimated_price, presence: true
  # validate :start_date_cannot_be_in_the_past, :arrival_date_cannot_be_before_start_date

  geocoded_by :start_city, latitude: :start_lat, longitude: :start_long
  after_validation :geocode, if: :start_city_changed?

  def self.passed
    where('start_date < ?', Date.current)
  end

  def self.coming
    where('start_date >= ?', Date.current)
  end

  def passed?
    true if arrival_date < Date.current
    # self.where('arrival_date < ?', Date.current)
  end

  def self.all_without_past_trips
    where('start_date >= ?', Date.today)
  end

  def update_confirmed_field
    confirmed_guests = 0
    self.bookings.each do |booking|
      confirmed_guests += booking.booking_guests
    end
    self.confirmed = true if confirmed_guests >= min_passengers_required
    save
  end

  def available_seats
    # refacto de Kevin le ouf
    # capacity - bookings.payed.pluck(:booking_guests).inject(O, :+)
    seats = 0
    bookings.each do |booking|
      seats += booking.booking_guests if booking.payment_status?
    end
    available_seats = capacity - seats
    return available_seats
  end

  def total_estimated_price!
    if self.has_car
      self.total_estimated_price = self.transportation_costs
    else
      self.total_estimated_price = self.transportation_costs + self.rental_costs
    end
    save
  end

  private

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Date.today
      errors.add(:start_date, "can't be in the past")
    end
  end

  def arrival_date_cannot_be_before_start_date
    if arrival_date.present? && arrival_date < start_date
      errors.add(:arrival_date, "can't be before the start date")
    end
  end

end
