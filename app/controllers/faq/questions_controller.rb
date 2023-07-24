class Faq::QuestionsController < ApplicationController
        # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
        before_action :move_to_signed_in, except: []
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
            redirect_to "/faq/question/list", notice: "投稿が成功しました。"
        else
            render :new
        end
    end

    #質問の一覧を取得する
    def list
        @questions_all = Question.order(created_at: :desc).page(params[:page_all]).per(128)
        @questions_men = Question.order(created_at: :desc).joins(:user).where(users: { gender: 1 }).page(params[:page_men]).per(128)
        @questions_women = Question.order(created_at: :desc).joins(:user).where(users: { gender: -1 }).page(params[:page_women]).per(128)
    end

    #詳細表示
    def show
        @question = Question.find(params[:id])

        # * アンサーフォームの設置
        @answer = Answer.new


        question_id = params[:id]
        @answers = Answer.order(created_at: :desc).where(question_id: @question.id)
    end

    # ! 編集画面
    def edit
        # * urlから投稿id取得
        @question = Question.find(params[:id])

        #ユーザーIDが自分のではなかった場合、他のユーザーIDから削除できないようにする。
        if @question.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        end
    end

    # ! 更新処理
    def update
        # * urlから投稿id取得
        @question = Question.find(params[:id])

        #ユーザーIDが自分のではなかった場合、他のユーザーIDから削除できないようにする。
        if @question.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        end

        # 更新
        if @question.update(posts_params)
            redirect_to "/question/list", notice: "投稿を編集しました"
        else
            redirect_to "/", alert: "投稿の編集に失敗しました"
        end
    end

    # ! 削除処理
    def delete
        # * urlから投稿id取得
        @question = Question.find(params[:id])

        #ユーザーIDが自分のではなかった場合、他のユーザーIDから削除できないようにする。
        if @question.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        end
    
        # 削除
        if @question.destroy
            redirect_to "/question/list", notice: "投稿を削除しました"
        else
            redirect_to "/", alert: "投稿の編集に削除しました"
        end
    end
    
    # ! (privateは外部クラスから参照できない)
    private

    # ! 投稿時、編集時にバインドするパラメータ
    def posts_params
        # * Closetモデルにバインドする
        params.require(:question).permit(:photograph, :question, :category)
    end


        # ! ログインがしているのか判定する
        def move_to_signed_in
            unless user_signed_in?
                redirect_to new_user_session_path, alert: "この操作は、サインインが必要です。"
            end
        end
end
