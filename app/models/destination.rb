class Destination < ApplicationRecord
  has_many :steps
  geocoded_by :location
  after_validation :geocode, if: :location_changed?
end
