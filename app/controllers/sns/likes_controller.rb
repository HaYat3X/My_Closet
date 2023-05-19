class Sns::LikesController < ApplicationController

    #いいねする機能
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

    #いいねを解除する機能
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

end
