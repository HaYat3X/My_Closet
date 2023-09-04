class Social < ApplicationRecord
    # ! ユーザーテーブルとのアソシエーション
    belongs_to :user

    # ! SNSいいねテーブルとのアソシエーション
    has_many :social_likes, dependent: :destroy

    # ! バリデーション
    validates :photograph, presence: true
    validates :tag, presence: true
    validates :title, presence: true

    # ! photgraphカラムとアップローダを関連付ける
    mount_uploader :photograph, SnsImageUploader
end
