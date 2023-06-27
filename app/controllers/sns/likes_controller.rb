class Sns::LikesController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []

    # ! 特定の情報をいいねするメソッド
    def create_like
        post_id = params[:id]
        user_id = current_user.id
        @likenew = SocialLike.new(social_id: post_id, user_id: user_id)

        if @likenew.save
            redirect_to request.referer, notice: "いいねをしました"
        else
            redirect_to request.referer, alert: "いいねに失敗しました"
        end
    end

    # ! 特定の情報のいいね解除するメソッド
    def delete_like
        post_id = params[:id]
        user_id = current_user.id

        # * いいね削除するデータを取得
        @likedelete = SocialLike.find_by(social_id: post_id, user_id: user_id)

        if @likedelete.destroy
            redirect_to request.referer, notice: "いいねを解除しました"
        else
            redirect_to request.referer, alert: "いいね解除に失敗しました"
        end
    end

    private

    # ! サインインしているのか判定する
    def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path, alert: "この操作は、サインインが必要です。"
        end
    end
end