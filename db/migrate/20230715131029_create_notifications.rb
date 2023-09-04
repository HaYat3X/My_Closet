class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :user_id, null: false
      t.string :notification_type, null: false
      t.integer :source_user_id, null: false
      t.integer :source_post_id, null: false
      t.integer :read, null: false, default: 0
      t.timestamps
    end
  end
end
