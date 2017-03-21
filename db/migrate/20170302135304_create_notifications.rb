class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.boolean :read, default: false
      t.string :content
      t.references :user, foreign_key: true
      t.references :topic, polymorphic: true, index: true

      t.timestamps
    end
  end
end
