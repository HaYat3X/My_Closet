class Admin::AlertsController < ApplicationController
    # * お知らせ投稿フォーム
    def new
        @alert = Alert.new() 
    end

    # * お知らせ登録
    def create
        @alert = Alert.new(posts_params)

        if @alert.save
            redirect_to "/"
        else
            render :new
        end
    end

    # * お知らせ一覧取得
    def list
        @alert_list = Alert.all()
    end

    # * お知らせ詳細表示
    def show
        @alert = Alert.find(params[:id])

    end

    private

    # ! 投稿時にバインドするパラメータ
    def posts_params
        params.require(:alert).permit(:title, :content)
    end
end
