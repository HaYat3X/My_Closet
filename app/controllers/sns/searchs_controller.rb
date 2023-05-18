class Sns::SearchsController < ApplicationController
    # 検索メソッド
    def search
        key_word = params[:search].upcase
        @search_result = Social.where('search LIKE (?)', "%#{key_word}%")
    end
end
