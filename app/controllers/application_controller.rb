class ApplicationController < ActionController::Base
    # ! サインアップする前にconfigure_permitted_parameters関数を呼び出す
    before_action :configure_permitted_parameters, if: :devise_controller?
    before_action :set_common_variable
    protected

    # ! ユーザ名をサインアップ時に登録させる
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :gender])
    end

    private

    # ! デフォルトで利用する変数を定義
    def set_common_variable
        # * 通知数を表示する
        if user_signed_in?
            @number_of_notifications = Notification.where(user_id: current_user.id).where.not(source_user_id: current_user.id).order(created_at: :desc).where(read: 0)
        else
            @number_of_notifications = []
        end
    end
end
