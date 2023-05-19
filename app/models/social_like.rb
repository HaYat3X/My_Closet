class SocialLike < ApplicationRecord
    # ! ユーザーテーブルとのアソシエーション
    belongs_to :user

    # ! ソーシャルテーブルとのアソシエーション
    belongs_to :social
end
