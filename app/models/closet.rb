class Closet < ApplicationRecord
    # ! ユーザーテーブルとのアソシエーション
    belongs_to :user

    # ソーシャルテーブルのアソシエーション
    belongs_to :social

    # ! バリデーション
    validates :photograph, presence: true
    validates :big_Category, presence: true

    # ! photgraphカラムとアップローダを関連付ける
    mount_uploader :photograph, ClosetImageUploader
end
