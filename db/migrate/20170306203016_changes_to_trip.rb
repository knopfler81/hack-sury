class ChangesToTrip < ActiveRecord::Migration[5.0]
  def change
    add_column :trips, :transportation_costs, :integer
    add_column :trips, :rental_costs, :integer
  end
end
