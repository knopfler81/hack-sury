class RemoveAgeToUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :age
    add_column :users, :birth_date, :date
  end
end
