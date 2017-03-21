class Notification < ApplicationRecord
  belongs_to :user
  belongs_to :topic, polymorphic: true

  def mark_as_read
    self.read = true
    self.save
  end

  def self.unread(user)
    where(read: false, user: user)
  end
end
