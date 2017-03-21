class Review < ApplicationRecord
  belongs_to :trip
  belongs_to :user
  has_attachment :best_picture
  validates :user, presence: true
  validates :description, presence: true

end


