class Coordinates::PostsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []

    # ! クローゼットテーブルからログインしているユーザーの登録したアイテム情報のみを取得するメソッド
    def list
        # * 全てのカテゴリー
        @closets_all = get_closets_by_category(nil)

        # * アウターカテゴリー
        @closets_outer = get_closets_by_category("アウター")

        # * トップスカテゴリー
        @closets_tops = get_closets_by_category("トップス")

        # * ボトムスカテゴリー
        @closets_pants = get_closets_by_category("ボトムス")

        # * シューズカテゴリー
        @closets_shoes = get_closets_by_category("シューズ")

        # * その他カテゴリー
        @closets_other = get_closets_by_category("その他")
    end

    # ! アイテムを登録するフォームのメソッド
    def new
        @closet = Closet.new()
    end

    # ! フォームの内容を取得し、データを保存するメソッド
    def create
        # * フォームに入力された値をセットする
        @closet = Closet.new(posts_params)

        # * フォームに入力された大カテゴリーと小カテゴリーとカラーとサイズと値段とブランドを連結する
        search_value = [params[:closet][:big_Category], params[:closet][:small_Category], params[:closet][:color], params[:closet][:size], params[:closet][:brand], params[:closet][:price]].join

        # * searchカラムにsearch_valueを保存する
        @closet.search = search_value

        # * 投稿者の情報を保存する
        @closet.user_id = current_user.id

        # * クローゼット登録の成功、失敗を判定
        if @closet.save
            redirect_to "/closet/list", notice: "アイテムを登録しました。"
        else
            render :new
        end
    end

    # ! アイテムを編集するフォームのメソッド
    def edit
        # * urlから投稿IDを取得
        post_id = params[:id]

        # * post_idと一致するクローゼットテーブルのデータを一件取得する
        @closet = Closet.find(post_id)

        # * 編集権限がない場合、リダイレクトする
        if @closet.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        end
    end

    # ! フォームの内容を取得し、更新するメソッド
    def update
        # * urlから投稿IDを取得
        post_id = params[:id]

        # * post_idと一致するクローゼットテーブルのデータを一件取得する
        @closet = Closet.find(post_id)

        # * 編集権限がない場合、リダイレクトする
        if @closet.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        end

        # * フォームに入力された大カテゴリーと小カテゴリーとカラーとサイズと値段とブランドを連結する
        search_value = [params[:closet][:big_Category], params[:closet][:small_Category], params[:closet][:color], params[:closet][:size], params[:closet][:brand], params[:closet][:price]].join

        # * クローゼット更新の成功、失敗を判定する
        if @closet.update(posts_params.merge(search: search_value))
            redirect_to "/closet/show/#{post_id}", notice: "投稿を編集しました"
        else
            redirect_to "/", alert: "投稿の編集に失敗しました"
        end
    end

    # ! 特定のアイテムを一件取得するメソッド
    def show
        # URLから投稿ID取得
        post_id = params[:id]

        # post_idと一致するクローゼットテーブルのデータを一件取得する
        @closet = Closet.find(post_id)

        # 小カテゴリーと色の情報を取得する
        small_Category = @closet.small_Category
        color = @closet.color

        # 小カテゴリーと色情報に一致するアイテムIDを取得する
        item_id = Closet.where.not(user_id: current_user.id)
                        .joins(:user)
                        .where(users: { gender: current_user.gender })
                        .where(small_Category: small_Category, color: color)
                        .limit(4)
                        .pluck(:id)

        # 類似しているアイテムを表示
        @coordinate_items = []

        item_id.each do |item|
            coordinate = Social.where("item1 = :item OR item2 = :item OR item3 = :item OR item4 = :item OR item5 = :item OR item6 = :item", item: item)
            @coordinate_items << coordinate
        end
    end

    # ! 特定のアイテムを削除するメソッド
    def delete
        # * urlから投稿id取得
        post_id = params[:id]

        # * post_idと一致するクローゼットテーブルのデータを一件取得する
        closet = Closet.find(post_id)

        # * 削除権限がない場合、リダイレクトする
        if closet.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        end

        # * クローゼット削除の成功、失敗を判定する
        if closet.destroy
            redirect_to "/closet/list", notice: "投稿を削除しました"
        else
            redirect_to "/", alert: "投稿の削除に失敗しました"
        end
    end

    # ! 大カテゴリーに基づいて小カテゴリーを返すメソッド
    def realtime_selected_value
        # * ユーザが入力した大カテゴリーを取得
        big_category = params[:selected_value]

        # * 大カテゴリーの値に基づいて、返す小カテゴリーの情報を変数にセット
        categories = {
            "アウター" => ["ベスト", "ジャケット", "トラックジャケット", "MA-1", "マウンテンパーカー", "レザージャケット", "ウインドブレーカー", "ダウンジャケット", "コート", "ピーコート"],

            "トップス" => ["タンクトップ", "Tシャツ", "ブラウス", "ポロシャツ", "シャツ", "スウェット", "パーカー", "カーディガン", "ニットセーター", "ワンピース"
            ],

            "ボトムス" => ["ショーツ", "パンツ", "ジーンズ", "レギンス", "スカート", "オーバーオール"],

            "シューズ" => ["スニーカー", "サンダル", "ブーツ", "パンプス", "フラットシューズ", "ローファー", "革靴"],

            "その他" => ["ネックレス", "ブレスレット", "ピアス", "キャップ", "リング", "ヘアアクセサリー", "ネクタイ", "ベルト", "バック", "その他"]
        }

        # * 大カテゴリーの値に基づいて、小カテゴリーに返す
        small_Category = categories[big_category] || []

        # * JSON形式でレスポンスを返す
        render json: { options: small_Category }
    end

    # ! ブランドを検索するメソッド
    def brand_search
        # * ユーザーが検索したブランドの情報を取得する
        key_word = '%' + params[:search] + '%'

        # * 大文字、小文字を区別せずに検索
        search_result = Closet.where("LOWER(brand) LIKE ?", "%#{key_word.downcase}%").distinct.pluck(:brand)

        # * JSON形式でレスポンスを返す
        render json: { options: search_result }
    end

    private

    # ! 投稿時、編集時にバインドするパラメータ
    def posts_params
        # * Closetモデルにバインドする
        params.require(:closet).permit(:photograph, :big_Category, :small_Category, :price, :color, :size, :brand)
    end

    # ! サインインしているのか判定する
    def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path, alert: "この操作は、サインインが必要です。"
        end
    end

    # ! クローゼットを各カテゴリー毎に取得する
    def get_closets_by_category(category)
        # * ログインしているユーザーが登録したアイテムを取得する
        query = Closet.order(created_at: :desc).where(user_id: current_user.id)

        # * カテゴリーがある場合とない場合を判定する
        query = query.where(big_Category: category) if category.present?
        query.page(params[:page]).per(40)
    end
end