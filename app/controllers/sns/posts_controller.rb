class Sns::PostsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: [:list, :show]

    # ! SNSテーブルの中から全データを取得するメソッド
    def list
        # * 全ての投稿か、フォロー中のみのリクエストか判定
        if params[:followed_only] == 'true'
            # ? フォローしているユーザーを取得する
            @follow = UserRelation.where(follow_id: current_user.id)

            # ? フォロー中のユーザーの投稿を全て取得する
            @sns_all = Social.where(user_id: @follow.pluck(:follower_id)).order(created_at: :desc).page(params[:page_all])

            # ? フォロー中の男性ユーザーの投稿を全て取得する
            @sns_men = Social.joins(:user).where(users: { gender: 1 }).where(user_id: @follow.pluck(:follower_id)).order(created_at: :desc).page(params[:page_men])

            # ? フォロー中の女性ユーザーの投稿を全て取得する
            @sns_women = Social.joins(:user).where(users: { gender: -1 }).where(user_id: @follow.pluck(:follower_id)).order(created_at: :desc).page(params[:page_women])
        else
            # ? ALLタブに表示するデータを取得する
            @sns_all = Social.order(created_at: :desc).page(params[:page_all])

            # ? 男性の投稿のみ取得する
            @sns_men = Social.joins(:user).where(users: { gender: 1 }).order(created_at: :desc).page(params[:page_men])

            # ? 女性の投稿のみ取得する
            @sns_women = Social.joins(:user).where(users: { gender: -1 }).order(created_at: :desc).page(params[:page_women])
        end
    end

    # ! 特定の投稿１件を取得するメソッド
    def show
        # * URLから投稿IDを取得する
        post_id = params[:id]

        # * post_idと一致するSNSテーブルのidを一件取得する
        @sns = Social.find(post_id)

        # * 着用したアイテム情報をクローゼットテーブルから取得する
        @item1 = Closet.find_by(id: @sns.item1)
        @item2 = Closet.find_by(id: @sns.item2)
        @item3 = Closet.find_by(id: @sns.item3)
        @item4 = Closet.find_by(id: @sns.item4)
        @item5 = Closet.find_by(id: @sns.item5)
        @item6 = Closet.find_by(id: @sns.item6)
    end

    # ! アイテムを投稿するフォームのメソッド
    def new
        @social = Social.new()

        # * ログインしているユーザーのクローゼットアイテムを取得する
        @closets_all = Closet.where(user_id: current_user.id)
        @closets_outer = Closet.where(user_id: current_user.id).where(big_Category: "アウター")
        @closets_all = Closet.where(user_id: current_user.id)
        @closets_all = Closet.where(user_id: current_user.id)
        @closets_all = Closet.where(user_id: current_user.id)

    end

    # ! 投稿フォームに入力された情報をテーブルに保存するメソッド
    def create
        # * ログインしているユーザーのクローゼットアイテムを取得する
        @closets_all = Closet.where(user_id: current_user.id)

        # * フォームに入力されたデータをセットする
        @social = Social.new(posts_params)

        # * 投稿者の情報を保存する
        @social.user_id = current_user.id

        # * フォームに入力された投稿文と、スタイルを連結する
        sns_search_value = params[:social][:tag].to_s + params[:social][:message].to_s + params[:social][:title].to_s

        # * クローゼットアイテムの選択された情報を取得
        selected_elements = params[:elements]

        # * 選択した値を処理し、選択したアイテムの情報を取得
        if selected_elements

            # ? 投稿時に何件のクローゼットのアイテムを選択したのか、どのアイテムを選択したのか判定する
            selected_elements.each_with_index do |element_id, index|

                # もし、選択されたアイテム数が６件を超えた場合は、処理を中断する
                break if index >= 6

                # 選択されたクローゼットアイテムの情報を保存する
                column_name = "item#{index + 1}"
                @social[column_name] = element_id

                # 選択されたクローゼットアイテムのsearchカラムの情報を取得する
                closet_search_value = selected_elements.take(6).map do |element_id|
                    Closet.find_by(id: element_id)&.search.to_s
                end.compact

                # 取得したクローゼットアイテムのcloset_search_valueとsns_search_valueの文字列を連結する
                @social.search = (closet_search_value || []).join("") + sns_search_value
            end
        else
            # ? クローゼットアイテムが選択されなかったら、sns_search_valueを保存する
            @social.search = sns_search_value
        end

        # * SNS投稿の成功、失敗を判定する
        if @social.save
            redirect_to "/", notice: "コーディネートを投稿しました。"
        else
            render :new
        end
    end

    # ! 特定の一件の編集情報を取得するメソッド
    def edit
        # * urlから投稿id取得
        post_id = params[:id]

        # * post_idと一致するSNSテーブルのidを一件取得する
        @social = Social.find(post_id)

        # * ログインしているユーザーのクローゼットアイテムを取得する
        @closets_all = Closet.where(user_id: current_user.id)

        # * 選択しているアイテムを追加
        @item1 = @social.item1 
        @item2 = @social.item2 
        @item3 = @social.item3 
        @item4 = @social.item4 
        @item5 = @social.item5
        @item6 = @social.item6

        # * 編集権限がない場合、リダイレクトする
        if @social.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        end
    end

    # ! 特定のデータを更新するメソッド
    def update
        # * urlから投稿id取得
        post_id = params[:id]

        # * post_idと一致するSNSテーブルのidを一件取得する
        @social = Social.find(post_id)

        # * 編集権限がない場合は、リダイレクトする
        if @social.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        end

        # * ログインしているユーザーのクローゼットアイテムを取得する
        @closets_all = Closet.where(user_id: current_user.id)

        # * フォームに入力された投稿文と、スタイルを連結する
        sns_search_value = params[:social][:tag].to_s + params[:social][:message].to_s + params[:social][:title].to_s

        # * 選択したアイテムを取得
        selected_elements = params[:elements]

        # * クローゼットアイテムを選択されているか判定する
        if selected_elements
            # ? 一件も選択されていない場合、全てのクローゼットアイテムをnilに更新する
            @social.update(item1: nil, item2: nil, item3: nil, item4: nil, item5: nil, item6: nil)
            @social.reload

            # ? 投稿時に何件のクローゼットのアイテムを選択したのか、どのアイテムを選択したのか判定する
            selected_elements.each_with_index do |element_id, index|

                # もし、選択されたアイテム数が６件を超えた場合は、処理を中断する
                break if index >= 6

                # 選択されたクローゼットアイテムの情報を保存する
                column_name = "item#{index + 1}"
                @social[column_name] = element_id

                # 選択されたクローゼットアイテムのsearchカラムの情報を取得する
                closet_search_value = selected_elements.take(6).map do |element_id|
                    Closet.find_by(id: element_id)&.search.to_s
                end.compact

                # 取得したクローゼットアイテムのcloset_search_valueとsns_search_valueの文字列を連結する
                @social.search = (closet_search_value || []).join("") + sns_search_value
            end
        else
            # ? 何も選択されなかったらitem1~6のカラムを初期化する
            (1..6).each { |index| @social["item#{index}"] = nil }
            @social.search = sns_search_value
        end

        # * SNS更新の成功、失敗を判定する
        if @social.update(posts_params)
            redirect_to "/", notice: "コーディネートを更新しました。"
        else
            redirect_to "/", alert: "投稿の編集に失敗しました"
        end
    end

    # ! 特定の情報を削除するメソッド
    def delete
        # * urlから投稿id取得
        post_id = params[:id]

        # * post_idと一致するSNSテーブルのidを一件取得する
        social = Social.find(post_id)

        # * 削除権限がない場合は、リダイレクトする
        if social.user_id != current_user.id
            redirect_to "/", alert: "不正なアクセスが行われました。"
        end

        # * SNS削除の成功、失敗を判定する
        if social.destroy
            redirect_to "/", notice: "投稿を削除しました。"
        else
            redirect_to "/", alert: "投稿の削除に失敗しました。"
        end
    end

    private

    # ! 投稿時、編集時にバインドするパラメータ
    def posts_params
        # * socialモデルにバインドする
        params.require(:social).permit(:title, :tag, :message, :photograph)
    end

    # ! サインインしているのか判定する
    def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path, alert: "この操作は、サインインが必要です。"
        end
    end
end
