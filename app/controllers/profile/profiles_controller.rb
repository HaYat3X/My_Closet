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
end
