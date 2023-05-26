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

        # * 検索カラムに値を挿入する。（謎に、三個以上連結するとエラー）
        case0 = params[:social][:tag].to_s + params[:social][:message].to_s

        # ? アイテム1の検索カラムを取得する
        if params[:social][:item1]
            case1 = Closet.find(params[:social][:item1]).search.to_s
        else
            case1 = "".to_s
        end

        # ? アイテム2の検索カラムを取得する
        if params[:social][:item2]
            case2 = Closet.find(params[:social][:item2]).search.to_s
        else
            case2 = "".to_s
        end

        # ? アイテム1の検索カラムを取得する
        if params[:social][:item3]
            case3 = Closet.find(params[:social][:item3]).search.to_s
        else
            case3 = "".to_s
        end

        # ? アイテム1の検索カラムを取得する
        if params[:social][:item4]
            case4 = Closet.find(params[:social][:item4]).search.to_s
        else
            case4 = "".to_s
        end

        # ? アイテム5の検索カラムを取得する
        if params[:social][:item5]
            case5 = Closet.find(params[:social][:item5]).search.to_s
        else
            case5 = "".to_s
        end

        # ? アイテム6の検索カラムを取得する
        if params[:social][:item6]
            case6 = Closet.find(params[:social][:item5]).search.to_s
        else
            case6 = "".to_s
        end

        search_bind = case0 + case1 + case2 + case3 + case4 + case5 + case6

        @social.search = search_bind

        # * 投稿が成功したら一覧表示ページへリダイレクト、投稿失敗時はエラーメッセージを表示する
        if @social.save
            redirect_to "/"
        else
            render :new
        end
    end

    def edit
        # * urlから投稿id取得
        post_id = params[:id]
        @social = Social.find(post_id)
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
        #ユーザーIDが自分のではなかった場合、他のユーザーIDから削除できないようにする。
        if @social.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        end

    end

    # ! 編集処理メソッド
    def update
        post_id = params[:id]
        @social = Social.find(post_id)
        # 投稿者の編集者の相違時のエラー
        if @social.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        end

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

        # * 検索カラムに値を挿入する。（謎に、三個以上連結するとエラー）
        case0 = params[:social][:tag].to_s + params[:social][:message].to_s 

        # ? アイテム1の検索カラムを取得する
        if params[:social][:item1]
            case1 = Closet.find(params[:social][:item1]).search.to_s
        else
            case1 = "".to_s
        end

        # ? アイテム2の検索カラムを取得する
        if params[:social][:item2]
            case2 = Closet.find(params[:social][:item2]).search.to_s
        else
            case2 = "".to_s
        end

        # ? アイテム1の検索カラムを取得する
        if params[:social][:item3]
            case3 = Closet.find(params[:social][:item3]).search.to_s
        else
            case3 = "".to_s
        end

        # ? アイテム1の検索カラムを取得する
        if params[:social][:item4]
            case4 = Closet.find(params[:social][:item4]).search.to_s
        else
            case4 = "".to_s
        end

        # ? アイテム5の検索カラムを取得する
        if params[:social][:item5]
            case5 = Closet.find(params[:social][:item5]).search.to_s
        else
            case5 = "".to_s
        end

        # ? アイテム6の検索カラムを取得する
        if params[:social][:item6]
            case6 = Closet.find(params[:social][:item5]).search.to_s
        else
            case6 = "".to_s
        end

        search_bind = case0 + case1 + case2 + case3 + case4 + case5 + case6

        @social.update(search: search_bind)


        # * でーたべーすにほぞん
        if @social.update(posts_params)
            redirect_to "/closet/list", notice: "投稿を編集しました"
        else
            redirect_to"/closet/list", alert: "投稿の編集に失敗しました"
        end
    end

    # ! 削除処理メソッド
    def delete
          # * urlから投稿id取得
        post_id = params[:id]
        social = Social.find(post_id)

        #ユーザーIDが自分のではなかった場合、他のユーザーIDから削除できないようにする。
        if social.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        else
            # 投稿の削除後、listのページに戻るコード
            if social.destroy
                redirect_to "/", notice: "投稿を削除しました"
            else
                redirect_to "/", alert: "投稿の削除に失敗しました"
            end
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
