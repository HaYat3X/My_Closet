class Social < ApplicationRecord
    # ! ユーザーテーブルとのアソシエーション
    belongs_to :user

    # クローゼットテーブルのアソシエーション
    belongs_to :closet
end
