class Sns::SearchsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: [:search]

    # 検索メソッド
    def search
        # * フォームの値を受け取る
        key_word = '%' + params[:search] + '%'
        # * 大文字、小文字を区別せずに検索
        social_table = Social.arel_table
        # * 検索
        @search_result = Social.where(social_table[:search].matches(key_word)).page(params[:page]).per(48)
    end

     # ! ログインがしているのか判定する
     def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path, alert: "この操作は、ログインが必要です。"
        end
    end
end
