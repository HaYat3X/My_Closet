class CreateSocialLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :social_likes do |t|
      t.references :user, foreign_key: true, null: false
      t.references :social, foreign_key: true, null: false
      t.timestamps
    end
  end
end
