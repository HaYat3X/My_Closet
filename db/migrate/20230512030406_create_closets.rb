class CreateClosets < ActiveRecord::Migration[6.1]
  def change
    create_table :closets do |t|
      t.references :user, foreign_key: true, null: false
      t.string :photograph, null: false
      t.string :big_Category, null: false
      t.string :small_Category
      t.integer :price
      t.string :color
      t.string :size
      t.string :brand
      t.string :search
      t.timestamps
    end
  end
end
