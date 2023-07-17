class ApplicationController < ActionController::Base
    # ! サインアップする前にconfigure_permitted_parameters関数を呼び出す
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    # ! ユーザ名をサインアップ時に登録させる
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
    end

    # # ! ログインした後に遷移する画面
    # def after_sign_in_path_for(resource)
    #     closet_list_path
    # end
end
