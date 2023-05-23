class Faq::QuestionsController < ApplicationController
    # ! 登録フォーム用メソッド
    def new
        # * 使用するモデルを定義する
        @question = Question.new
    end

    # ! 登録処理用メソッド
    def create
        # * 投稿時にバインドするパラメータを付与する
        @question = Question.new(posts_params)

        # * ログインしているユーザの情報を取得し、user_idのカラムにバインドする
        @question.user_id = current_user.id

        # * 投稿が成功したら一覧表示ページへリダイレクト、投稿失敗時はエラーメッセージを表示する
        if @question.save
            redirect_to "/"
        else
            render :new
        end
    end
    
    # ! (privateは外部クラスから参照できない)
    private

    # ! 投稿時、編集時にバインドするパラメータ
    def posts_params
        # * Closetモデルにバインドする
        params.require(:question).permit(:photograph, :question, :category,)
    end
end
