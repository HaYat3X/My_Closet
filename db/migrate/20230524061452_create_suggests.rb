class CreateSuggests < ActiveRecord::Migration[6.1]
  def change
    create_table :suggests do |t|
      t.references :user, foreign_key: true, null: false
      t.string :content
      t.timestamps
    end
  end
end
