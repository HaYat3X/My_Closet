class User < ApplicationRecord
  # ! メール認証ができるように設定変更
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable
  # クローゼットテーブルのアソシエーション
  has_many :closets
end
