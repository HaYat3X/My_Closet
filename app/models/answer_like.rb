class AnswerLike < ApplicationRecord
    # ! userテーブルとのアソシエーション
    belongs_to :user
    # ! answerテーブルとのアソシエーション
    belongs_to :answer
end
