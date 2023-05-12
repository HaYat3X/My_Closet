class Closet < ApplicationRecord
    # ユーザーテーブルとのアソシエーション
    belongs_to :user

    #バリデーション
    validates :photograph, presence: true
    validates :big_Category, presence: true
end
