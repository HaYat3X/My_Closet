class User < ApplicationRecord
  # ! メール認証ができるように設定変更
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable, :confirmable, :lockable, :timeoutable, :trackable

  # クローゼットテーブルのアソシエーション
  has_many :closets, dependent: :destroy

  # ソーシャルテーブルのアソシエーション
  has_many :socials, dependent: :destroy

  #ソーシャルライクテーブルのアソシエーション
  has_many :social_likes, dependent: :destroy

  #questionテーブルのアソシエーション
  has_many :questions, dependent: :destroy

  # answerテーブルのアソシエーション
  has_many :answers, dependent: :destroy

  # answer_likeテーブルのアソシエーション
  has_many :answer_likes, dependent: :destroy

  # 1対1の関係を定義するユーザは一つの提案を持っていることになる
  has_one :suggest

  # ! photgraphカラムとアップローダを関連付ける
  mount_uploader :avatar, UserImageUploader

  # ! バリデーション
  validates :user_name, presence: true, length: { maximum: 20 }
  validates :gender, presence: true
  validates :height, numericality: { greater_than: 0, less_than: 300 }, allow_blank: true
  validates :weight, numericality: { greater_than: 0, less_than: 600 }, allow_blank: true
end
