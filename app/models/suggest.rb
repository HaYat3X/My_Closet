class Suggest < ApplicationRecord
    # ユーザテーブルとのアソシエーション
    belongs_to :user

    # ! バリデーション
    validates :eye_color, presence: true
    validates :hair_color, presence: true
    validates :skin_color, presence: true
    validates :size, presence: true
    validates :style1, presence: true
    validates :style2, presence: true
    validates :style3, presence: true
    validates :total_price, presence: true
end
