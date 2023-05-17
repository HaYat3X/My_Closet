class Sns::PostsController < ApplicationController
    # ! 一覧取得メソッド
    def list
        @snss = Social.all.page(params[:page]).per(40)
    end    

    # ! 詳細取得メソッド
    def show
        # * 詳細情報を一件取得する
        @sns = Social.find(5)

        # * item1〜6のアイテム情報をクローゼットテーブルから取得する
        @item1 = Closet.find_by(id: @sns.item1)
        @item2 = Closet.find_by(id: @sns.item2)
        @item3 = Closet.find_by(id: @sns.item3)
        @item4 = Closet.find_by(id: @sns.item4)
        @item5 = Closet.find_by(id: @sns.item5)
        @item6 = Closet.find_by(id: @sns.item6)
    end

    # ! 投稿フォームメソッド
    def new
        @social = Social.new
    end

    # ! 登録処理メソッド
    def create
         # * 投稿時にバインドするパラメータを付与する
        @social = Social.new(posts_params)

          # * ログインしているユーザの情報を取得し、user_idのカラムにバインドする
        @social.user_id = current_user.id

         # * 投稿が成功したら一覧表示ページへリダイレクト、投稿失敗時はエラーメッセージを表示する
        if @social.save
            redirect_to "/"
        else
            render :new
        end
    end

    # ! (privateは外部クラスから参照できない)
    private

    # ! 投稿時、編集時にバインドするパラメータ
    def posts_params
        # * socialモデルにバインドする
        params.require(:social).permit(:tag, :message, :photograph, :item1, :item2, :item3, :item4, :item5, :item6)
    end

end
