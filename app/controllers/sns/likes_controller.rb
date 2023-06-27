class Sns::LikesController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []

    # ! 特定の情報をいいねするメソッド
    def create_like
        # * URLから投稿IDを取得する
        post_id = params[:id]

        # * ログイン中のユーザIDを取得する
        user_id = current_user.id

        # * いいねする
        @likenew = SocialLike.new(social_id: post_id, user_id: user_id)

        # * いいね保存が成功、失敗の判定を行う
        if @likenew.save
            redirect_to request.referer, notice: "いいねをしました。"
        else
            redirect_to request.referer, alert: "いいねに失敗しました。"
        end
    end

    # ! 特定の情報のいいね解除するメソッド
    def delete_like
        # * URLから投稿IDを取得する
        post_id = params[:id]

        # * ログイン中のユーザIDを取得する
        user_id = current_user.id

        # * いいねされている情報を取得する
        @likedelete = SocialLike.find_by(social_id: post_id, user_id: user_id)

        # * いいね削除が成功、失敗の判定をする
        if @likedelete.destroy
            redirect_to request.referer, notice: "いいねを解除しました。"
        else
            redirect_to request.referer, alert: "いいね解除に失敗しました。"
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