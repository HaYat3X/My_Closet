class CreateSocialLikes < ActiveRecord::Migration[6.1]
  def change
    create_table :social_likes do |t|
      t.integer :post_id
      t.integer :user_id
      t.timestamps
    end
    # ! 外部キー規約
    add_index :social_likes, :user_id
    add_index :social_likes, :post_id
  end
end
