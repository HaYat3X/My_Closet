class Profile::ProfilesController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []

    # ! ログイン中のユーザを取得
    def show
        # * パラメータからユーザIDを取得
        @user = User.find(params[:id])

        # * ログイン中のユーザが投稿した着こなしQ&A投稿を取得
        @faq = Question.order(created_at: :desc).where(user_id: @user.id).page(params[:page]).per(16)

        # ログイン中のユーザが投稿したSNS投稿
        @sns_all = Social.order(created_at: :desc).where(user_id: @user.id).page(params[:page_sns])

        #ログイン中のユーザーがいいねしたSNS投稿
        @sns_like = Social.joins(:social_likes).where(social_likes: { user_id: @user.id }).order(created_at: :desc).page(params[:page_like])

        #ログイン中のユーザーが投稿したクローゼット
        @closets = Closet.order(created_at: :desc).where(user_id: @user.id).page(params[:page_closet])

        # フォロー数
        @follow_list = UserRelation.order(created_at: :desc).where(follow_id: params[:id]).count

        # ファロワー数
        @follower_list = UserRelation.order(created_at: :desc).where(follower_id: params[:id]).count
    end

    # ! ユーザーのプロフィール更新メソッド
    def edit
        #　DBに保存されているユーザの登録情報抜き出す
        @user = User.find(params[:id])
        
        # * 編集権限がない場合はリダイレクト
        if @user.id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        end
    end

    # ! データを更新
    def update
        @user = User.find(params[:id])
      
        # * 編集権限がない場合はリダイレクト
        if @user.id != current_user.id
          redirect_to "/", alert: "不正なアクセスが行われました。"
        end
    

        # * プロフィールの更新処理が成功しているか判定する
        if @user.update(posts_params)
            redirect_to "/profile/show/#{@user.id}", notice: "プロフィールを編集しました"
        else
            render :edit
        end
    end
    
    private

    # ! 編集時にバインドするパラメータ
    def posts_params
        # * Userモデルにバインドする
        params.require(:user).permit(:avatar, :user_name, :height, :weight, :age, :gender, :profile)
    end

    # ! ログインがしているのか判定する
    def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path, alert: "この操作は、サインインが必要です。"
        end
    end
end
