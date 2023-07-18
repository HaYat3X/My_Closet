class Profile::AlertsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []

    # * お知らせを一覧取得
    def list
        @alerts = Alert.order(created_at: :desc)
        # * 自分に当てられた通知かつ、通知の作成元が自分以外の通知を取得
        @notification = Notification.where(user_id: current_user.id).where.not(source_user_id: current_user.id).order(created_at: :desc).order(read: :asc)
    end
    
    # * お知らせ詳細取得
    def show
        @id = params[:id]

        if @id.end_with?("_management")
            @alert = Alert.find(params[:id].chomp("_management"))
        else
            @notification = Notification.find(params[:id])
            # * 通知を発生させたユーザー情報
            @source_user_id = User.find(@notification.source_user_id)

            if @notification.source_post_id != 0
                if @notification.notification_type === "like"
                    # * SNSいいね通知投稿
                    @source_post_id = Social.where(id: @notification.source_post_id).first
                else
                    # * 回答
                    @source_answer_post_id = Question.find(@notification.source_post_id)
                end
            end
            
            # * 通知を既読にする
            if @notification.update(read: 1)
                render :show
            else
                render :show
            end
        end        
    end    

    private

    # ! ログインがしているのか判定する
    def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path, alert: "この操作は、サインインが必要です。"
        end
    end
end
