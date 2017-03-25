class CreateProspects < ActiveRecord::Migration[5.0]
  def change
    create_table :prospects do |t|
      t.string :email
      t.string :telephone

      t.timestamps
    end
  end
end
