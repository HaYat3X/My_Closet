class Question < ApplicationRecord

    #questionテーブルのアソシエーション
    belongs_to :user

    # ! photgraphカラムとアップローダを関連付ける
    mount_uploader :photograph, QuestionsImageUploader

    # ! バリデーション
    validates :photograph, presence: true
    validates :question, presence: true
    validates :category, presence: true

    #answerテーブルのアソシエーション
    has_many :answers, dependent: :destroy
end
