class MonetizeBooking < ActiveRecord::Migration[5.0]
  def change
  remove_column :bookings, :booking_price, :integer
  add_monetize :bookings, :booking_price, currency: { present: false }
  add_column :bookings, :payment, :json
  end
end
