class Step < ApplicationRecord
  belongs_to :trip
  belongs_to :destination

  after_validation :find_destination

  private

  def find_destination
    destination = Destination.find_or_create_by(location: self.step_location)
    self.destination_id = destination.id
  end
end
