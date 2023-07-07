class Sns::SearchsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: [:search]

    # ! 検索フォームに入力されているキーワードを元に、SNSテーブルの情報を検索するメソッド
    def search
        # * 入力フォームの値を受け取る
        key_word = '%' + params[:search] + '%'

        # * search_socialメソッドを使用してSNSレコードを取得する
        @search_result = search_social(key_word).page(params[:page]).per(48)
    end

    private

    # ! サインインしているのか判定する
    def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path, alert: "この操作は、ログインが必要です。"
        end
    end

    # ! 与えられた検索キーワードに部分一致するSNSレコードを検索するメソッド
    def search_social(key_word)
        # * 検索キーワードに部分一致するSNSレコードを検索する
        Social.where("LOWER(search) LIKE ?", key_word.downcase)
    end
end
