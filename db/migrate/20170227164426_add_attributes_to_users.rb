class AddAttributesToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :firt_name, :string
    add_column :users, :last_name, :string
    add_column :users, :nickname, :string
    add_column :users, :age, :integer
    add_column :users, :driving_licence, :boolean
    add_column :users, :avatar, :string
    add_column :users, :bio, :text
    add_column :users, :admin, :boolean, null: false, default: false
  end
end
