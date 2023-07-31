class Suggestion::SuggestionsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []

    # ! 入力 => ユーザの提案情報
    # ! 加工 => 提案情報に基づいてコーディネートを取得する
    # ! 出力 => SNSのコーディネート20件
    def suggestion
        # * ユーザ情報を取得
        @user = User.find(current_user.id)

        # * ログインしているユーザ以外のユーザ情報を取得
        other_users = User.where.not(id: current_user.id)

        # * AIによる提案情報が存在するか判定
        if Suggest.exists?(user_id: current_user.id)
            # ? ユーザに提案されたファッションスタイルを取得する
            suggest = Suggest.find_by(user_id: current_user.id)

            # ? 提案情報に基づいてコーディネートを取得する
            # @suggestions = Social.where("(tag LIKE ? OR tag LIKE ?) AND user_id != ?", suggest.style1 ||= "", suggest.style2 ||= "", current_user.id).joins(:user).where(users: { gender: @user.gender }).order("RANDOM()").limit(4)
            # ! 男なのに女の投稿も表示されるのをなおす
        end

        # * パーソナルカラーを判定
        favorite_colors = {
            favorite_color1: @user.favorite_color1,
            favorite_color2: @user.favorite_color2,
            favorite_color3: @user.favorite_color3,
            favorite_color4: @user.favorite_color4,
            favorite_color5: @user.favorite_color5
        }

        # * パーソナルカラーを特定
        @most_favorite_colour = favorite_colors.max_by { |_, color| color.to_i }.first
        
        # * 結果を出力
        @recommend = recommend(@user, other_users)
    end

    # ! ユーザの好みを決定する
    def user_like_create
        @user = User.find(current_user.id)

        if @user.update(posts_params)
            redirect_to "/suggestion", notice: "好みを設定しました。"
        else
            redirect_to "/suggestion", alert: "好みを設定に失敗しました。"
        end
    end

    # ! (privateは外部クラスから参照できない)
    private
    
    # ! ログインがしているのか判定する
    def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path, alert: "この操作は、サインインが必要です。"
        end
    end

    # ! 編集時にバインドするパラメータ
    def posts_params
        # * Userモデルにバインドする
        params.require(:user).permit(:size, :favorite_color1, :favorite_color2, :favorite_color3, :favorite_color4, :favorite_color5, :total_price)
    end

    # !  レコメンドする
    def recommend(user, other_users)
        # * ログインしているユーザーのベクトルを作成
        user_vector = [
            # ? 属性を設定していない場合は、0を代入
            user.size.nil? ? 0 : user.size,
            user.size.nil? ? 0 : user.favorite_color1,
            user.size.nil? ? 0 : user.favorite_color2,
            user.size.nil? ? 0 : user.favorite_color3,
            user.size.nil? ? 0 : user.favorite_color4,
            user.size.nil? ? 0 : user.favorite_color5,
            user.total_price.nil? ? 0 : user.total_price
        ]

        other_users_vectors = other_users.pluck(:size, :favorite_color1, :favorite_color2, :favorite_color3, :favorite_color4, :favorite_color5, :total_price).map do |vector|
            # ? 属性を設定していない場合は、0を代入
            vector.map { |element| element.nil? ? 0 : element }
        end

        # * 類似度と類似度を測定したユーザーを格納する配列
        similarities = []

        # * 類似度を計算するユーザー情報とベクトルを付与
        other_users_vectors.each_with_index do |other_users_vector, i|
            # ? 類似度を計算
            similarity = cosine_similarity(user_vector, other_users_vector)

            # ? 類似度の結果とユーザー情報を配列に格納
            similarities << [other_users[i], similarity]
        end

        # * 1に近い（類似度が高い）順に並び替え
        similarities.sort_by! { |similarity| similarity[1] }.reverse!

        # * コサイン類似度の高いユーザーを表示
        similar_users = similarities.map { |similarity| similarity[0] }

        # * コーディネートを格納する配列
        posts = []

        # * 類似度の高いユーザ順にコーディネートを取得する
        similar_users.each do |user|
            # ? 性別が同じユーザーから投稿を取得
            if user.gender == user.gender
                # ? 一人のユーザーから最大5件の投稿をランダムに取得する
                user_posts = Social.where(user_id: user.id).order("RANDOM()").limit(5)

                # ? 配列に格納
                posts.concat(user_posts)

                # ? 20件取得したら終了
                break if posts.size >= 20
            end
        end

        # * 提案された投稿を返す
        posts
    end

    # ! コサイン類似度計算
    def cosine_similarity(vector1, vector2)
        # * 変数の初期化
        dot_product = 0
        norm1 = 0
        norm2 = 0

        # * ログインしているユーザーとそれ以外のユーザーの内積と２乗を計算
        vector1.each_with_index do |v1, i|
            v2 = vector2[i]

            # ? ベクトル1とベクトル2の内積
            dot_product += v1 * v2

            # ? ベクトル1の２乗した値
            norm1 += v1 * v1

            # ? ベクトル2の２乗した値
            norm2 += v2 * v2
        end

        # * 0ベクトルの場合、類似度を0として扱う
        if norm1.zero? || norm2.zero?
            similarity = 0
        else
            # ? 内積をベクトル1の２乗とベクトル2の２乗で割る
            similarity = dot_product / (Math.sqrt(norm1) * Math.sqrt(norm2))
        end

        # * 類似度を返す
        similarity
    end
end
