class Profile::AlertsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: [:list, :show]

    # * お知らせを一覧取得
    def list
        @alerts = Alert.all().order(created_at: :desc)
        # * 自分に当てられた通知かつ、通知の作成元が自分以外の通知を取得
        # @notification = Notification.where(user_id: current_user.id).where.not(source_user_id: current_user.id)
        @notification = Notification.where(user_id: current_user.id)
        pp @notification
    end
    
    # * お知らせ詳細取得
    def show
        @notification = Notification.find(params[:id])
        # * 通知を発生させたユーザー情報
        @source_user_id = User.find(@notification.source_user_id)

        # * SNSいいね通知投稿
        @source_post_id = Social.find(@notification.source_post_id)

        # * 回答
        @source_answer_post_id = Question.find(@notification.source_post_id)
    end    

    private

    # ! ログインがしているのか判定する
    def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path, alert: "この操作は、サインインが必要です。"
        end
    end
end
