class CreateSuggests < ActiveRecord::Migration[6.1]
  def change
    create_table :suggests do |t|
      t.references :user, foreign_key: true, null: false
      t.string :style1, null: false
      t.string :style2, null: false
      t.timestamps
    end
  end
end
