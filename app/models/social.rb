class Social < ApplicationRecord
    # ! ユーザーテーブルとのアソシエーション
    belongs_to :user
end
