class CreateUserContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :user_contacts do |t|
      t.string :email, null: false
      t.string :name, null: false
      t.string :content, null: false
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
