class ApplicationController < ActionController::Base
    # ! サインアップする前にconfigure_permitted_parameters関数を呼び出す
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    # ! ユーザ名をサインアップ時に登録させる
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name, :gender])
    end
end
