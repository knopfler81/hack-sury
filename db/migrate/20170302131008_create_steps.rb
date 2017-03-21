class CreateSteps < ActiveRecord::Migration[5.0]
  def change
    create_table :steps do |t|
      t.references :trip, foreign_key: true
      t.references :destination, foreign_key: true

      t.timestamps
    end
  end
end
