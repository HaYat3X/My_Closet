class UserContact < ApplicationRecord
    # ! バリデーション
    validates :email, presence: true

    validates :name, presence: true

    validates :content, presence: true
end
