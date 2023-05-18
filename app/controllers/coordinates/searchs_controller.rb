class Coordinates::SearchsController < ApplicationController
    # 検索用メソッド
    def search
        # * フォームの値を受け取る
        key_word = '%' + params[:search] + '%'
        # * 大文字、小文字を区別せずに検索
        closet_table = Closet.arel_table
        # * 検索
        @search_result = Closet.where(closet_table[:search].matches(key_word))
    end
end
