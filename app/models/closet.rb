class Closet < ApplicationRecord
    # ! ユーザーテーブルとのアソシエーション
    belongs_to :user

    # ! バリデーション
    validates :photograph, presence: true
    validates :big_Category, presence: true
    # validates :color, presence: true

    # ! photgraphカラムとアップローダを関連付ける
    mount_uploader :photograph, ClosetImageUploader
end
