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

    # * お知らせ編集フォーム
    def edit
        @alert = Alert.find(params[:id])

    end

    # * お知らせ更新フォーム
    def update
        @alert = Alert.find(params[:id])

        if @alert.update(posts_params)
            redirect_to "/"
        else
            render :new
        end
    end

    # * お知らせ削除フォーム
    def delete
        @alert = Alert.find(params[:id])

        if @alert.destroy
            redirect_to "/", notice: "投稿を削除しました"
        else
            redirect_to "/", alert: "投稿の削除に失敗しました"
        end
    end

    private

    # ! 投稿時にバインドするパラメータ
    def posts_params
        params.require(:alert).permit(:title, :content)
    end
end
