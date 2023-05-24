class Faq::AnswersController < ApplicationController
    # ! FAQ回答処理用メソッド
    def create
        # * 投稿時にバインドするパラメータを付与する
        # * 質問詳細を取得する
        @question = Question.find(params[:id])

        @answer = Answer.new(posts_params)

        # * ログインしているユーザの情報を取得し、user_idのカラムにバインドする
        @answer.user_id = current_user.id

        # * 投稿をIDを保存
        @answer.question_id = params[:id]

        # * 投稿が成功したら一覧表示ページへリダイレクト、投稿失敗時はエラーメッセージを表示する
        if @answer.save
            redirect_to "/"
        else
            render template: 'faq/questions/show'
        end
    end

    # ! 編集

    # ! 関数
    private

        # ! 回答時にバインドするパラメータ
    def posts_params
        # * Closetモデルにバインドする
        params.require(:answer).permit(:photograph, :answer)
    end
end
