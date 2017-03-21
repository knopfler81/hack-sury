class AddMotivationMessageToBooking < ActiveRecord::Migration[5.0]
  def change
    add_column :bookings, :motivation_message, :text
  end
end
