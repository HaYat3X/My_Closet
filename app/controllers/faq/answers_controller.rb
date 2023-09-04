class Faq::AnswersController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []

    def new
        @answer = Answer.new()

        # * 回答する質問を取得
        @question = Question.find(params[:id])
    end

    # ! FAQ回答処理用メソッド
    def create
        # * 投稿時にバインドするパラメータを付与する
        # * 質問詳細を取得する
        @question = Question.find(params[:id])

        @answer = Answer.new(posts_params)

        # * ログインしているユーザの情報を取得し、user_idのカラムにバインドする
        @answer.user_id = current_user.id

        # * 投稿をIDを保存
        @answer.question_id = @question.id

        # * 投稿が成功したら一覧表示ページへリダイレクト、投稿失敗時はエラーメッセージを表示する
        if @answer.save
            # ? 通知を作成
            notice = Notification.create(user_id: @question.user_id, notification_type: "answer", source_user_id: current_user.id, source_post_id: @answer.question_id)
            redirect_to "/faq/question/show/#{@question.id}", notice: "質問に回答しました。"
        else
            render :new
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

        @question = Question.find(@answer.question_id)
    
        # 削除
        if @answer.destroy
            notice = Notification.where(user_id: @question.user_id, notification_type: "answer", source_user_id: current_user.id, source_post_id: @answer.question_id).first

            notice.destroy
            redirect_to "/faq/question/show/#{@question.id}", notice: "投稿を削除しました"
        else
            redirect_to "/", alert: "投稿の編集に削除しました"
        end
    end

    # ! 編集
    def edit
        # * urlから投稿id取得
        @answer = Answer.find(params[:id])

        # * 質問を取得
        @question = Question.find(@answer.question_id)

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

                # * 質問を取得
                @question = Question.find(@answer.question_id)

        # 更新
        if @answer.update(posts_params)
            redirect_to "/faq/question/show/#{@question.id}", notice: "回答を編集しました"
        else
            redirect_to "/", alert: "投稿の編集に失敗しました。"
        end
    end

    # ! 関数
    private

        # ! 回答時にバインドするパラメータ
    def posts_params
        # * Closetモデルにバインドする
        params.require(:answer).permit(:photograph, :answer)
    end


        # ! ログインがしているのか判定する
        def move_to_signed_in
            unless user_signed_in?
                redirect_to new_user_session_path, alert: "この操作は、サインインが必要です。"
            end
        end
end
