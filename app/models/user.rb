class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
	devise :omniauthable, omniauth_providers: [:facebook]

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
	has_many :passenger_bookings, class_name: "Booking"
	has_many :organisator_bookings, through: :trips, class_name: "Booking"

  has_many :trips # Trip where user is organizer
  has_many :passenger_trips, through: :passenger_bookings, class_name: "Trip", source: :trip # Trip where user is passenger

  has_attachment :avatar, accept: [:jpg, :jpeg, :png, :gif]
  # validates :last_name, :first_name, presence: true
  has_many :notifications

  validate :check_if_user_is_18
  #validates :nickname, uniqueness: true


  def passed_trips_as_organisator
    trip_as_organisator = []
    trips.each do |trip|
      trip_as_organisator << trip if trip.passed?
    end
    trip_as_organisator
  end

  def passed_trips_as_passenger
    passenger_trips = []
    passenger_bookings.each do |booking|
      passenger_trips << booking.trip if booking.trip.passed?
    end
    passenger_trips
  end

  def upcoming_trips_as_passenger
    passenger_trips = []
    passenger_bookings.each do |booking|
      passenger_trips << booking.trip
    end
    passenger_trips
  end

  def motivations
    passenger_motivations = []
    passenger_bookings.each do |booking|
      passenger_motivations << booking.motivation_message
    end
    passenger_motivations
  end

  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:avatar_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.where(provider: auth.provider, uid: auth.uid).first
    user ||= User.where(email: auth.info.email).first # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else
      user = User.new(user_params)
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end

  def update_with_password(params={})
    params.delete(:current_password)
    self.update_without_password(params)
  end

  def signed_without_oauth?
    provider != "facebook"
  end


  def age
    if birth_date.present?
      now = Time.now.utc.to_date
      now.year - birth_date.year - ((now.month > birth_date.month || (now.month == birth_date.month && now.day >= birth_date.day)) ? 0 : 1)
    end
  end

  def avatar_url
    if avatar.present?
      avatar.path
    else
      'http://placehold.it/100x100'
    end
  end

  def completed_profile?
    if bio.present? && nickname.present? && birth_date.present? && first_name.present? && last_name.present? && avatar.present?
      true
    else
      false
    end
  end

  private

  def check_if_user_is_18
    if birth_date.present? && birth_date >= 18.years.ago
      errors.add(:birth_date, 'You should be over 18 years old.')
    end
  end
end
