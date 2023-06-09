class Profile::AlertsController < ApplicationController
    # * お知らせを一覧取得
    def list
        @alerts = Alert.all()
    end
    
    # * お知らせ詳細取得
    def show
        @alert = Alert.find(params[:id])
    end    
end
