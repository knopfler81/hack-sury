require 'rails_helper'

describe Notification do
  it { should belong_to(:user) }
  it { should belong_to(:topic) }

  describe '#mark_as_read' do
    it 'sets read status to true' do
      notification = build(:notification, read: false)

      notification.mark_as_read

      expect(notification.read).to be_truthy
    end
  end

  describe '.unread' do
    it 'returns only unread notifications' do
      user = create(:user, email: 'viny212@formentera.es', password: 'wakewake')
      notification_read = create(:notification, read: true, user: user)
      notification_unread = create(:notification, read: false, user: user)

      unread_notifications = Notification.unread(user)

      expect(unread_notifications.size).to eq(1)
      expect(unread_notifications.first).to eq(notification_unread)
    end
  end
end
