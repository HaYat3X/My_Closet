class Profile::AlertsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: [:list, :show]

    # * お知らせを一覧取得
    def list
        @alerts = Alert.all()
    end
    
    # * お知らせ詳細取得
    def show
        @alert = Alert.find(params[:id])
    end    

    private

    # ! ログインがしているのか判定する
    def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path, alert: "この操作は、サインインが必要です。"
        end
    end
end
