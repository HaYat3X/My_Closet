class Faq::LikesController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []


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


    # ! (privateは外部クラスから参照できない)
    private
    # ! ログインがしているのか判定する
    def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path, alert: "この操作は、サインインが必要です。"
        end
    end

end
