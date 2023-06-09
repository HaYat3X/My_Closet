class Faq::SearchsController < ApplicationController
    # ! 検索結果を表示する
    def search
        key_word = '%' + params[:search] + '%'
        # * 大文字、小文字を区別せずに検索
        question_table = Question.arel_table
        # * 検索
        @search_result = Question.where(question_table[:category].matches(key_word))
    end
end
