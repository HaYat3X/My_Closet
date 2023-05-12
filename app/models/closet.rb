class Closet < ApplicationRecord
    # ユーザーテーブルとのアソシエーション
    belongs_to :user
end
