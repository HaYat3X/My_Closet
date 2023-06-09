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

    # ! 削除
    def delete
        # * urlから投稿id取得
        @answer = Answer.find(params[:id])

        #ユーザーIDが自分のではなかった場合、他のユーザーIDから削除できないようにする。
        if @answer.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        end
    
        # 削除
        if @answer.destroy
            redirect_to "/question/list", notice: "投稿を削除しました"
        else
            redirect_to"/question/list", alert: "投稿の編集に削除しました"
        end
    end

    # ! 編集
    def edit
        # * urlから投稿id取得
        @answer = Answer.find(params[:id])

        #ユーザーIDが自分のではなかった場合、他のユーザーIDから削除できないようにする。
        if @answer.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        end
    end

    # ! 更新処理
    def update
        # * urlから投稿id取得
        @answer = Answer.find(params[:id])

        #ユーザーIDが自分のではなかった場合、他のユーザーIDから削除できないようにする。
        if @answer.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        end

        # 更新
        if @answer.update(posts_params)
            redirect_to "/question/list", notice: "投稿を編集しました"
        else
            redirect_to"/question/list", alert: "投稿の編集に失敗しました"
        end
    end

    # ! 関数
    private

        # ! 回答時にバインドするパラメータ
    def posts_params
        # * Closetモデルにバインドする
        params.require(:answer).permit(:photograph, :answer)
    end
end
