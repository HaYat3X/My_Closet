class Coordinates::SearchsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []

    # ! キーワードを元に、クローゼットテーブルの情報を検索するメソッド
    def search
        # * 検索されたキーワードの値を受け取る
        key_word = '%' + params[:search] + '%'

        # * 大文字、小文字を区別せずに検索
        @search_result = Closet.where("LOWER(search) LIKE ?", key_word.downcase)
    end

    private

    # ! ログインがしているのか判定する
    def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path, alert: "この操作は、サインインが必要です。"
        end
    end
end
