class Sns::PostsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: [:list, :show]

    # ! 一覧取得メソッド
    def list
        # * SNS投稿一覧取得 SNSに48件取得
        @snss = Social.order(created_at: :desc).page(params[:page]).per(48)

        # * ログインしているユーザーがフォローしているユーザーの投稿を取得
        if user_signed_in?
           @follow = UserRelation.where(follow_id: current_user.id) 
        end
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
        @closets_all = Closet.where(user_id: current_user.id).limit(12)
        @c = Closet.where(user_id: current_user.id)

        # if @c >= 12
        #     existing_ids = @closets_all.pluck(:id)
        #     additional_closets = Closet.where(user_id: current_user.id).where.not(id: existing_ids).limit(12)
        #     @closets_all += additional_closets
        
        # end

        @count = @c.length

        # * realtime_reload_itemsリンクから値を取得
        # @reload_items = params[:items]
        # * Closetからアイテムを追加したい場合


        # * Closetモデルを介して、アウターアイテムのみ取得する
        @closets_outer = Closet.where(big_Category: "アウター", user_id: current_user.id)

        # * Closetモデルを介して、トップスアイテムのみ取得する
        @closets_tops = Closet.where(big_Category: "トップス", user_id: current_user.id)

        # * Closetモデルを介して、パンツアイテムのみ取得する
        @closets_pants = Closet.where(big_Category: "ボトムス", user_id: current_user.id)

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
        @closets_pants = Closet.where(big_Category: "ボトムス", user_id: current_user.id)

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

        # * 選択したアイテムを取得
        selected_elements = params[:elements] # チェックボックスの値が配列として取得されます

        # * 選択した値を処理し、選択したアイテムの情報を取得
        if selected_elements
            selected_elements.each_with_index do |element_id, index|
                break if index >= 6  # 最大6件の制限を設定する
            
                column_name = "item#{index + 1}"
                @social[column_name] = element_id
    
                search_params = selected_elements.take(6).map { |element_id| Closet.find(element_id).search.to_s }
                @social.search = search_params.join("") + case0
            end
        else
            @social.search = case0
        end


        # * 投稿が成功したら一覧表示ページへリダイレクト、投稿失敗時はエラーメッセージを表示する
        if @social.save
            # ? ユーザの投稿頻度の高いタグを保存するプログラムを実行
            suggestions_controller = Suggestion::ApisController.new()
            suggestions_controller.call_user(current_user.id)
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
        @closets_pants = Closet.where(big_Category: "ボトムス", user_id: current_user.id)

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

         # ** 一度選択したアイテムは削除できないため、一旦nullに
        @social.item1 = nil 
        @social.item2 = nil 
        @social.item3 = nil 
        @social.item4 = nil 
        @social.item5 = nil 
        @social.item6 = nil 

        # * 変更を保存、且つ再読み込み
        @social.save
        @social.reload
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
         @closets_pants = Closet.where(big_Category: "ボトムス", user_id: current_user.id)
 
         # * Closetモデルを介して、シューズアイテムのみ取得する
         @closets_shoes = Closet.where(big_Category: "シューズ", user_id: current_user.id)
 
         # * Closetモデルを介して、その他のアイテムのみ取得する
        @closets_other = Closet.where(big_Category: "その他", user_id: current_user.id)

        # * 検索カラムに値を挿入する。（謎に、三個以上連結するとエラー）
        case0 = params[:social][:tag].to_s + params[:social][:message].to_s 

         # * 選択したアイテムを取得
        selected_elements = params[:elements] # チェックボックスの値が配列として取得されます

         # * 選択した値を処理し、選択したアイテムの情報を取得
        if selected_elements
            selected_elements.each_with_index do |element_id, index|
                break if index >= 6  # 最大6件の制限を設定する
            
                column_name = "item#{index + 1}"
                @social[column_name] = element_id
    
                search_params = selected_elements.take(6).map { |element_id| Closet.find(element_id).search.to_s }
                @social.search = search_params.join("") + case0
            end
        else
            @social.search = case0
        end
 

        # * でーたべーすにほぞん
        if @social.update(posts_params)
            # ? ユーザの投稿頻度の高いタグを保存するプログラムを実行
            suggestions_controller = Suggestion::ApisController.new()
            suggestions_controller.call_user(current_user.id)
            redirect_to "/sns/show/#{post_id}", notice: "投稿を編集しました"
        else
            redirect_to"/", alert: "投稿の編集に失敗しました"
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
        params.require(:social).permit(:tag, :message, :photograph)
    end

     # ! ログインがしているのか判定する
     def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path, alert: "この操作は、サインインが必要です。"
        end
    end
end
