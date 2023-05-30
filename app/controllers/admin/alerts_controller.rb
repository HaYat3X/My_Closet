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

    private

    # ! 投稿時にバインドするパラメータ
    def posts_params
        params.require(:alert).permit(:title, :content)
    end
end
