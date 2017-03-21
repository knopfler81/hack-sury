class RemoveEstimatedRentalPriceToTrip < ActiveRecord::Migration[5.0]
  def change
    remove_column :trips, :estimated_rental_price
  end
end
