class Profile::FollowsController < ApplicationController
    # ! フォローを作成するメソッド
    def create_follow
        # * １、フォローされる人のIDを取得
        follower = params[:id].to_i
       
        # * ２、フォローする人のIDを取得
        follow = current_user.id

        # * ３、１,２のデータを保存
        create_follow = UserRelation.new(follow_id: follow, follower_id: follower)

        if create_follow.save
            redirect_to "/"
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
            redirect_to "/"
        else
            redirect_to "/"
        end
    end

    # ! フォロー一覧を取得するメソッド
    def follow_list
        # ユーザ全員のデータ
        @users = User.all()
        # * あるユーザーがフォローしているユーザー一覧を取得
        @follow_list = UserRelation.where(follow_id: params[:id])
    end

    # ! フォローわー一覧を取得するメソッド
    def follower_list
        # ユーザ全員のデータ
        @users = User.all()

        # * あるユーザーがフォローされているユーザー一覧を取得
        @follower_list = UserRelation.where(follower_id: params[:id])
    end
end
