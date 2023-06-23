class Coordinates::SearchsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []

    # 検索用メソッド
    def search
        # * フォームの値を受け取る
        key_word = '%' + params[:search] + '%'
        # * 大文字、小文字を区別せずに検索
        closet_table = Closet.arel_table
        # * 検索
        @search_result = Closet.where(closet_table[:search].matches(key_word))
    end

    # ! (privateは外部クラスから参照できない)
    private

    # ! ログインがしているのか判定する
    def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path, alert: "この操作は、サインインが必要です。"
        end
    end

end
