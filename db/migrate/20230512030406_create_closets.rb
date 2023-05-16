class CreateClosets < ActiveRecord::Migration[6.1]
  def change
    create_table :closets do |t|
      t.integer :user_id
      t.string :photograph,  null: false
      t.string :big_Category,  null: false
      t.string :small_Category
      t.integer :price
      t.string :color
      t.string :size
      t.string :brand
      t.string :search
      t.timestamps
    end
    # ! 外部キー規約
    add_index :closets, :user_id
  end
end
