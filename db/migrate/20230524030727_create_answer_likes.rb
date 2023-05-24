class CreateAnswerLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :answer_likes do |t|
      t.references :user, foreign_key: true, null: false
      t.references :answer, foreign_key: true, null: false
      t.timestamps
    end
  end
end
