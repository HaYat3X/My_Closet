class Answer < ApplicationRecord
    # ! userテーブルとのアソシエーション
    belongs_to :user
    # ! questionテーブルとのアソシエーション
    belongs_to :question
    # ! answerテーブルからのanswers_likesテーブルとのアソシエーション
    has_many :answer_likes

    # ! photgraphカラムとアップローダを関連付ける
    mount_uploader :photograph, AnswersImageUploader

    # ! バリデーション
    validates :answer, presence: true
end
