class Social < ApplicationRecord
    # ! ユーザーテーブルとのアソシエーション
    belongs_to :user

    # ! バリデーション
    validates :photograph, presence: true
    # ! photgraphカラムとアップローダを関連付ける
    mount_uploader :photograph, SnsImageUploader
end
