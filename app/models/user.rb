class User < ApplicationRecord
  # ! メール認証ができるように設定変更
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable
  # クローゼットテーブルのアソシエーション
  has_many :closets

  # ソーシャルテーブルのアソシエーション
  has_many :socials

  #ソーシャルライクテーブルのアソシエーション
  has_many :social_likes

  #questionテーブルのアソシエーション
  has_many :questions

# answerテーブルのアソシエーション
  has_many :answers
end
