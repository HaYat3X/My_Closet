class Faq::LikesController < ApplicationController
    # ! いいねメソッド
    def create_like
        post_id = params[:id]
        user_id = current_user.id
        @likenew = AnswerLike.new(user_id: user_id, answer_id: post_id)

        if @likenew.save
            redirect_to request.referer, notice: "いいねをしました"
        else
            redirect_to request.referer, alert: "いいねに失敗しました"
        end
    end

    # ! いいね削除メソッド
    def delete_like
        post_id = params[:id]
        user_id = current_user.id

        # * いいね削除するデータを取得
        @likedelete = AnswerLike.find_by(user_id: user_id, answer_id: post_id)

        if @likedelete.destroy
            redirect_to request.referer, notice: "いいねを解除しました"
        else
            redirect_to request.referer, alert: "いいね解除に失敗しました"
        end
    end
end
