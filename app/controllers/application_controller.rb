class ApplicationController < ActionController::Base
    # ! user_nameを登録時に登録させるための設定
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected

    # ! user_nameを登録時に登録させるための設定
    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:user_name])
    end
end
