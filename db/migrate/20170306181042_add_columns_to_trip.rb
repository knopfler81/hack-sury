class AddColumnsToTrip < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :has_car, :boolean
    add_column :trips, :estimated_rental_price, :integer
  end
end
