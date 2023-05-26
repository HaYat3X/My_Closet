class Profile::ProfilesController < ApplicationController
    # ! ログイン中のユーザを取得
    def show
        # ログイン中のユーザ情報
        @user = current_user 

        # ログイン中のユーザが投稿したSNS投稿
        @snss = Social.where(user_id:@user.id)

        #ログイン中のユーザーがいいねしたSNS投稿
        @sns_likes = SocialLike.where(user_id: @user.id)

        #ログイン中のユーザーが投稿したクローゼット
        @closets = Closet.where(user_id:@user.id)
    end

    # ! ユーザーのプロフィール更新メソッド
    def edit
        #　ログイン中のユーザ情報
        @user = current_user
        #　DBに保存されているユーザの登録情報抜き出す
        @user_data = User.find(@user.id)
    end

    # ! データを更新
    def update
        @user = User.find(current_user.id)
        # * 投稿の削除後、listのページに戻るコード
        if @user.update(posts_params)
            redirect_to "/profile/show", notice: "プロフィールを編集しました"
        else
            redirect_to"/profile/show", alert: "プロフィールの編集に失敗しました"
        end
    end

    private

    # ! 編集時にバインドするパラメータ
    def posts_params
        # * Userモデルにバインドする
        params.require(:user).permit(:avatar, :user_name, :height, :weight, :age, :gender, :profile)
    end

end
