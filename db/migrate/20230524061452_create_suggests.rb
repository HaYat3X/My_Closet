class CreateSuggests < ActiveRecord::Migration[6.1]
  def change
    create_table :suggests do |t|
      t.references :user, foreign_key: true, null: false
      t.string :style1, null: true
      t.string :style2, null: true
      t.timestamps
    end
  end
end
