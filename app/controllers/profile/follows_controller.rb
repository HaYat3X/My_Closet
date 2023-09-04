class Profile::FollowsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: [:follow_list, :follower_list]

    # ! フォローを作成するメソッド
    def create_follow
        # * １、フォローされる人のIDを取得
        follower = params[:id].to_i
    
        # * ２、フォローする人のIDを取得
        follow = current_user.id

        # * ３、１,２のデータを保存
        create_follow = UserRelation.new(follow_id: follow, follower_id: follower)

        if create_follow.save
            # ? 通知を作成
            notice = Notification.create(user_id: follower, notification_type: "follow", source_user_id: follow, source_post_id: 0)
            redirect_to request.referer, notice: "フォローしました"
        else
            redirect_to "/"
        end
    end

    # ! フォローを解除するメソッド
    def delete_follow
        # * １、フォロー解除される人のIDを取得
        follower_delete = params[:id].to_i
        # * ２、フォロー解除する人のIDを取得
        follow_delete = current_user.id

        # * ３、フォロー解除するデータを取得
        delete_follow = UserRelation.find_by(follow_id: follow_delete, follower_id: follower_delete)
        
        if delete_follow.destroy
            notice = Notification.where(user_id: follower_delete, notification_type: "follow", source_user_id: follow_delete, source_post_id: 0).first

            notice.destroy
            redirect_to request.referer, notice: "フォロー解除しました"
        else
            redirect_to "/"
        end
    end

    # ! フォロー一覧を取得するメソッド
    def follow
        @users = User.all()

        # * あるユーザーがフォローしているユーザー一覧を取得
        @follow_list = UserRelation.where(follow_id: params[:id]).page(params[:page_follow])

        # * あるユーザーがフォローされているユーザー一覧を取得
        @follower_list = UserRelation.where(follower_id: params[:id]).page(params[:page_follower])
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
