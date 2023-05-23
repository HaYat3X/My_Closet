class Answer < ApplicationRecord
     # ! userテーブルとのアソシエーション
    belongs_to :user
    # ! questionテーブルとのアソシエーション
    belongs_to :question
end
