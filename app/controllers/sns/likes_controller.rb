class Sns::LikesController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: [:like_ranking]

    # ! 特定の情報をいいねするメソッド
    def create_like
        # * URLから投稿IDを取得する
        post_id = params[:id]

        # * 投稿したユーザーIDを取得
        post = Social.find(post_id)
        post_user_id = post.user_id

        # * ログイン中のユーザIDを取得する
        user_id = current_user.id

        # * いいねする
        @likenew = SocialLike.new(social_id: post_id, user_id: user_id)

        # * いいね保存が成功、失敗の判定を行う
        if @likenew.save
            # ? 通知を作成
            notice = Notification.create(user_id: user_id, notification_type: "like", source_user_id: post_user_id, source_post_id: post_id)
            redirect_to request.referer, notice: "いいねをしました。"
        else
            redirect_to request.referer, alert: "いいねに失敗しました。"
        end
    end

    # ! 特定の情報のいいね解除するメソッド
    def delete_like
        # * URLから投稿IDを取得する
        post_id = params[:id]

        # * ログイン中のユーザIDを取得する
        user_id = current_user.id

        # * いいねされている情報を取得する
        @likedelete = SocialLike.find_by(social_id: post_id, user_id: user_id)

        # * いいね削除が成功、失敗の判定をする
        if @likedelete.destroy
            redirect_to request.referer, notice: "いいねを解除しました。"
        else
            redirect_to request.referer, alert: "いいね解除に失敗しました。"
        end
    end

    # ! いいねランキングメソッド
    def like_ranking
        # * 現在の月の開始日と開始時間を取得（ex.7/1 0:00）
        start_date = Time.current.beginning_of_month

        # * 現在の月の終了日と終了時間を取得（ex.7/31 23:59）
        end_date = Time.current.end_of_month

        # * 指定された期間内のいいね数を集計し、いいね数が多い投稿ID順にソートして、最大12件までの投稿IDを取得
        likes_count = SocialLike.where(created_at: start_date..end_date).group(:social_id).select('social_id, COUNT(*) AS likes_count').order('likes_count DESC').limit(12)

        # * ソートした結果を配列に格納
        social_ids = likes_count.map(&:social_id)

        # * likes_countのIDの数が12件に満たない場合、いいねが0の投稿を追加で取得
        if social_ids.length < 12

            # ? 12からlikes_countで取得したいいね数を引いて、追加する投稿数を判定
            remaining_limit = 12 - social_ids.length

            # ? likes_countで取得した以外の投稿を昇順に取得する
            zero_likes_social_ids = Social.where.not(id: social_ids).order(id: :ASC).limit(remaining_limit).pluck(:id)

            # ? 追加で取得したIDを配列に追加する
            social_ids += zero_likes_social_ids
        end

        # * 取得したIDの投稿を取得する
        @sns_ranking_all = Social.where(id: social_ids).sort_by { |s| social_ids.index(s.id) }

        # * 指定された期間内のいいね数を集計し、いいね数が多い投稿ID順にソートして、最大12件までの投稿IDを取得（男性のみ）
        likes_count = SocialLike.where(created_at: start_date..end_date).joins(social: :user).where(users: { gender: 1 }).group(:social_id).select('social_id, COUNT(*) AS likes_count').order('likes_count DESC').limit(12)

        # * ソートした結果を配列に格納
        social_ids = likes_count.map(&:social_id)

        # * likes_countのIDの数が12件に満たない場合、いいねが0の投稿を追加で取得
        if social_ids.length < 12

            # ? 12からlikes_countで取得したいいね数を引いて、追加する投稿数を判定
            remaining_limit = 12 - social_ids.length

            # ? likes_countで取得した以外の投稿を昇順に取得する
            zero_likes_social_ids = Social.joins(:user).where(users: { gender: 1 }).where.not(id: social_ids).order(id: :ASC).limit(remaining_limit).pluck(:id)

            # ? 追加で取得したIDを配列に追加する
            social_ids += zero_likes_social_ids
        end

        # * 取得したIDの投稿を取得する
        @sns_ranking_men = Social.where(id: social_ids).sort_by { |s| social_ids.index(s.id) }

        # * 指定された期間内のいいね数を集計し、いいね数が多い投稿ID順にソートして、最大12件までの投稿IDを取得（女性のみ）
        likes_count = SocialLike.where(created_at: start_date..end_date).joins(social: :user).where(users: { gender: -1 }).group(:social_id).select('social_id, COUNT(*) AS likes_count').order('likes_count DESC').limit(12)

        # * ソートした結果を配列に格納
        social_ids = likes_count.map(&:social_id)

        # * likes_countのIDの数が12件に満たない場合、いいねが0の投稿を追加で取得
        if social_ids.length < 12

            # ? 12からlikes_countで取得したいいね数を引いて、追加する投稿数を判定
            remaining_limit = 12 - social_ids.length

            # ? likes_countで取得した以外の投稿を昇順に取得する
            zero_likes_social_ids = Social.joins(:user).where.not(id: social_ids).where(users: { gender: -1 }).order(id: :ASC).limit(remaining_limit).pluck(:id)

            # ? 追加で取得したIDを配列に追加する
            social_ids += zero_likes_social_ids
        end

        # * 取得したIDの投稿を取得する
        @sns_ranking_women = Social.where(id: social_ids).sort_by { |s| social_ids.index(s.id) }
    end

    private

    # ! サインインしているのか判定する
    def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path, alert: "この操作は、サインインが必要です。"
        end
    end
end