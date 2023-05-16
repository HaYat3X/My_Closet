class Coordinates::SearchsController < ApplicationController
    # 検索用メソッド
    def search
        # * フォームの値を受け取る
        key_word = params[:search]
        # 検索用SQL
        @search_result = Closet.where('search LIKE (?)', "%#{key_word}%")
    end

end
