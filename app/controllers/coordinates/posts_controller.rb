class Coordinates::PostsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []

    # ! 一覧表示メソッド
    def list
        # * Closetモデルを介して、全データを取得する
        # ? ページネーションを導入し、1ページに40件のデータを表示する
        @closets_all = Closet.where(user_id: current_user.id).page(params[:page]).per(40)

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

    # ! 登録フォーム用メソッド
    def new
        # * 使用するモデルを定義する
        @closet = Closet.new
    end

    # ! 登録処理用メソッド
    def create
        # * 投稿時にバインドするパラメータを付与する
        @closet = Closet.new(posts_params)

        # * 検索カラムに値を挿入する。（謎に、三個以上連結するとエラー）
        case1 = params[:closet][:big_Category] + params[:closet][:small_Category] + params[:closet][:color] 
        case2 = params[:closet][:size] + params[:closet][:brand] + params[:closet][:price] 
        @closet.search = case1 + case2

        # * ログインしているユーザの情報を取得し、user_idのカラムにバインドする
        @closet.user_id = current_user.id

        # * 投稿が成功したら一覧表示ページへリダイレクト、投稿失敗時はエラーメッセージを表示する
        if @closet.save
            redirect_to "/"
        else
            render :new
        end
    end
    # ! アイテム更新フォームメソッド
    def edit
           # * urlから投稿id取得
        post_id = params[:id]
        @closet = Closet.find(post_id)
        #ユーザーIDが自分のではなかった場合、他のユーザーIDから削除できないようにする。
        if @closet.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        end
    end
    # ! アイテム更新メソッド
    def update
        post_id = params[:id]
        @closet = Closet.find(post_id)

        if @closet.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        end

        # * 検索カラムに値を挿入する。（謎に、三個以上連結するとエラー）
        # !! refactoring時にヘルパーに移行する
        case1 = params[:closet][:big_Category] + params[:closet][:small_Category] + params[:closet][:color] 
        case2 = params[:closet][:size] + params[:closet][:brand] + params[:closet][:price]

        # * searchカラムを更新する
        @closet.update(search: case1 + case2)

        # * 投稿の削除後、listのページに戻るコード
        if @closet.update(posts_params)
            redirect_to "/closet/list", notice: "投稿を編集しました"
        else
            redirect_to"/closet/list", alert: "投稿の編集に失敗しました"
        end
    end

    # ! アイテム詳細メソッド
    def show
        # * urlから投稿id取得
        post_id = params[:id]

        # * 投稿idの詳細データ
        @closet = Closet.find(post_id)
    end

    #投稿削除

    def delete
        # * urlから投稿id取得
        post_id = params[:id]
        closet = Closet.find(post_id)

        #ユーザーIDが自分のではなかった場合、他のユーザーIDから削除できないようにする。
        if closet.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        else
            # 投稿の削除後、listのページに戻るコード
            if closet.destroy
                redirect_to "/closet/list", notice: "投稿を削除しました"
            else
                redirect_to "/closet/list", alert: "投稿の削除に失敗しました"
            end
        end
    end

    #closetページの大カテゴリーをリアルタイムで取得する
    def realtime_selected_value
        selected_value = params[:selected_value]

            # 投稿の削除後、listのページに戻るコード
            if selected_value == "アウター"
                @small_Category = ["ジャケット","コート","ピーコート","ダウンジャケット","レザージャケット","ウインドブレーカー","カーディガン"]

            elsif selected_value == "トップス"
                @small_Category = ["Tシャツ","シャツ","ブラウス","ポロシャツ","ニットセーター","パーカー","ジャケット","スカート"]

            elsif selected_value == "ボトムス"
                @small_Category = ["ジーンズ","パンツ","ショートパンツ","スカート","レギンス","ショーツ"]

            elsif selected_value == "シューズ"
                @small_Category = ["スニーカー","パンプス","サンダル","ブーツ","フラットシューズ","革靴"]

            elsif selected_value == "その他"
                @small_Category = ["ネックレス","ブレスレット","ピアス","リング","ヘアアクセサリー","その他"]
            end

            render json: { options: @small_Category }
    end



    # ! (privateは外部クラスから参照できない)
    private

    # ! 投稿時、編集時にバインドするパラメータ
    def posts_params
        # * Closetモデルにバインドする
        params.require(:closet).permit(:photograph, :big_Category, :small_Category, :price, :color, :size, :brand)
    end

    # ! ログインがしているのか判定する
    def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path
        end
    end
end