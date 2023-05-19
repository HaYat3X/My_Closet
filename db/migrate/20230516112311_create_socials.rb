class CreateSocials < ActiveRecord::Migration[6.1]
  def change
    create_table :socials do |t|
      t.references :user, foreign_key: true, null: false
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
  end
end
