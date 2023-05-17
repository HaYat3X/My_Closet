class Sns::PostsController < ApplicationController
    # ! 一覧取得メソッド
    def list
        @snss = Social.all.page(params[:page]).per(40)
    end    

    # ! 詳細取得メソッド
    def show
        # * 詳細情報を一件取得する
        @sns = Social.find(params[:id])

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

        # * ログインしているユーザが登録したアイテムのデータを取得
        @closets_all = Closet.where(user_id: current_user.id)

        # * Closetモデルを介して、アウターアイテムのみ取得する
        @closets_outer = Closet.where(big_Category: "アウター", user_id: current_user.id)

        # * Closetモデルを介して、トップスアイテムのみ取得する
        @closets_tops = Closet.where(big_Category: "トップス", user_id: current_user.id)

        # * Closetモデルを介して、パンツアイテムのみ取得する
        @closets_pants = Closet.where(big_Category: "パンツ", user_id: current_user.id)

        # * Closetモデルを介して、シューズアイテムのみ取得する
        @closets_shoes = Closet.where(big_Category: "シューズ", user_id: current_user.id)

        # * Closetモデルを介して、その他のアイテムのみ取得する
        @closets_other = Closet.where(big_Category: "その他", user_id: current_user.id)
    end

    # ! 登録処理メソッド
    def create
         # * ログインしているユーザが登録したアイテムのデータを取得
         @closets_all = Closet.where(user_id: current_user.id)

         # * Closetモデルを介して、アウターアイテムのみ取得する
         @closets_outer = Closet.where(big_Category: "アウター", user_id: current_user.id)
 
         # * Closetモデルを介して、トップスアイテムのみ取得する
         @closets_tops = Closet.where(big_Category: "トップス", user_id: current_user.id)
 
         # * Closetモデルを介して、パンツアイテムのみ取得する
         @closets_pants = Closet.where(big_Category: "パンツ", user_id: current_user.id)
 
         # * Closetモデルを介して、シューズアイテムのみ取得する
         @closets_shoes = Closet.where(big_Category: "シューズ", user_id: current_user.id)
 
         # * Closetモデルを介して、その他のアイテムのみ取得する
         @closets_other = Closet.where(big_Category: "その他", user_id: current_user.id)

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
