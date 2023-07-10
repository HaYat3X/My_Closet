class Sns::LikesController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []

    # ! 特定の情報をいいねするメソッド
    def create_like
        # * URLから投稿IDを取得する
        post_id = params[:id]

        # * ログイン中のユーザIDを取得する
        user_id = current_user.id

        # * いいねする
        @likenew = SocialLike.new(social_id: post_id, user_id: user_id)

        # * いいね保存が成功、失敗の判定を行う
        if @likenew.save
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
        start_date = Time.current.beginning_of_month
        end_date = Time.current.end_of_month

        likes_count = SocialLike.where(created_at: start_date..end_date)
                            .group(:social_id)
                            .select('social_id, COUNT(*) AS likes_count')
                            .order('likes_count DESC')
                            .limit(12)

        social_ids = likes_count.map(&:social_id)

        # 足りない分だけいいねが0の投稿を取得
        if social_ids.length < 12
        remaining_limit = 12 - social_ids.length
        zero_likes_social_ids = Social.where.not(id: social_ids)
                                        .order(id: :asc)
                                        .limit(remaining_limit)
                                        .pluck(:id)
        social_ids += zero_likes_social_ids
        end

        puts "選択されたID: #{social_ids}"

@social_ranking_all = Social.where(id: social_ids).sort_by { |s| social_ids.index(s.id) }



# likes_count = SocialLike.where(created_at: start_date..end_date)
#                        .joins(social: :user)
#                        .where(users: { gender: 1 })
#                        .group(:social_id)
#                        .select('social_id, COUNT(*) AS likes_count')
#                        .order('likes_count DESC')
#                        .limit(12)

# social_ids = likes_count.map(&:social_id)

# # 足りない分だけいいねが0の男性投稿を取得
# if social_ids.length < 12
#   remaining_limit = 12 - social_ids.length
#   zero_likes_social_ids = Social.joins(:user)
#                                 .where(users: { gender: 1 })
#                                 .where.not(id: social_ids)
#                                 .order(id: :asc)
#                                 .limit(remaining_limit)
#                                 .pluck(:id)
#   social_ids += zero_likes_social_ids
# end

# puts "選択されたID: #{social_ids}"




    end

    private

    # ! サインインしているのか判定する
    def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path, alert: "この操作は、サインインが必要です。"
        end
    end
end