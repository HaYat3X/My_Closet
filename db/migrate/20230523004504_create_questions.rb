class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.references :user, foreign_key: true, null: false
      t.string :photograph, null: false
      t.string :question, null: false, limit: 100
      t.string :category, null: false
      t.timestamps
    end
  end
end
