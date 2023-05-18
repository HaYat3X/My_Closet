class CreateSocials < ActiveRecord::Migration[6.1]
  def change
    create_table :socials do |t|
      t.integer :user_id, null: false
      t.string :tag
      t.string :message
      t.string :photograph, null: false
      t.integer :item1
      t.integer :item2
      t.integer :item3
      t.integer :item4
      t.integer :item5
      t.integer :item6
      t.string :search
      t.timestamps
    end
    # ! 外部キー規約
    add_index :socials, :user_id
    add_index :socials, :item1
    add_index :socials, :item2
    add_index :socials, :item3
    add_index :socials, :item4
    add_index :socials, :item5
    add_index :socials, :item6
  end
end
