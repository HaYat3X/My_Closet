class Faq::SearchsController < ApplicationController

        # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
        before_action :move_to_signed_in, except: []
    # ! 検索結果を表示する
    def search
        key_word = '%' + params[:search] + '%'
        # * 大文字、小文字を区別せずに検索
        question_table = Question.arel_table
        # * 検索
        @search_result = Question.where(question_table[:category].matches(key_word))
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
