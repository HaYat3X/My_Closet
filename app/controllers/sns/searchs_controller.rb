class Sns::SearchsController < ApplicationController
    # 検索メソッド
    def search
        # * フォームの値を受け取る
        key_word = '%' + params[:search] + '%'
        # * 大文字、小文字を区別せずに検索
        social_table = Social.arel_table
        # * 検索
        @search_result = Social.where(social_table[:search].matches(key_word)).page(params[:page]).per(48)
    end
end
