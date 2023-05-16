class Coordinates::SearchsController < ApplicationController
    # 検索用メソッド
    def search
        # * フォームの値を受け取る (upcaseで大文字、小文字を区別せず検索できるように)
        key_word = params[:search].upcase
        # 検索用SQL
        @search_result = Closet.where('search LIKE (?)', "%#{key_word}%")
    end

end
