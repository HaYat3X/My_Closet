class CreateAlerts < ActiveRecord::Migration[6.1]
  def change
    create_table :alerts do |t|
      t.string :title, null: false
      t.string :content, null: false
      t.timestamps
    end
  end
end
