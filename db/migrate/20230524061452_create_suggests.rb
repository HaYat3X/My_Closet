class CreateSuggests < ActiveRecord::Migration[6.1]
  def change
    create_table :suggests do |t|
      t.references :user, foreign_key: true, null: false
      t.string :personal_color
      t.string :eye_color, null: false
      t.string :hair_color, null: false
      t.string :skin_color, null: false
      t.string :size, null: false
      t.integer :style1, null: false
      t.integer :style2, null: false
      t.integer :style3, null: false
      t.string :total_price
      t.timestamps
    end
  end
end
