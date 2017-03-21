class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.string :title
      t.text :description
      t.string :pictures
      t.string :start_city
      t.float :start_long
      t.float :start_lat
      t.string :arrival_city
      t.float :arrival_long
      t.float :arrival_lat
      t.date :start_date
      t.date :arrival_date
      t.boolean :flexible, default: true
      t.boolean :confirmed, default: false
      t.integer :total_estimated_price
      t.integer :capacity
      t.integer :min_passengers_required
      t.references :user, foreign_key: true
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
