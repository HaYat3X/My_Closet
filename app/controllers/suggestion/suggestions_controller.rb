class Suggestion::SuggestionsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []

    # ! コーディネートを提案
    def suggestion
        # * ユーザ情報
        @user = User.find(current_user.id)
        pp @user.user_name

        # * 提案情報があるかないか判定
        if Suggest.exists?(user_id: current_user.id)
            suggest = Suggest.find_by(user_id: current_user.id)

            # pp suggestion
            key_word1 = '%' + suggest.style1 + '%'
            key_word2 = '%' + suggest.style2 + '%'

            # * SNSの投稿データを返す（大文字と小文字を区別しない）
            @suggestions = Social.where("search LIKE ? OR search LIKE ?", key_word1, key_word2).where.not(user_id: current_user.id).order("RANDOM()").limit(20)

            # * おすすめのユーザを出力
            @users = User.where("tendency LIKE ? OR tendency LIKE ?", key_word1, key_word2).where.not(id: current_user.id).order("RANDOM()").limit(10)
        end

        # ! 強調フィルタリング
        # * ログインしているユーザ以外のユーザ情報を取得
        other_users = User.where.not(id: current_user.id)

        # * ログインしているユーザーのベクトルを作成
        current_user_vector = [
            # ? 属性を設定していない場合は、0を代入
            @user.size.nil? ? 0 : @user.size,
            @user.size.nil? ? 0 : @user.favorite_color1,
            @user.size.nil? ? 0 : @user.favorite_color2,
            @user.size.nil? ? 0 : @user.favorite_color3,
            @user.size.nil? ? 0 : @user.favorite_color4,
            @user.size.nil? ? 0 : @user.favorite_color5,
            @user.total_price.nil? ? 0 : @user.total_price
        ]

        puts "ログインしている人のベクトル:#{current_user_vector}"

        # * ログインしているユーザー以外のベクトルを作成
        other_users_vectors = other_users.pluck(:size, :favorite_color1, :favorite_color2, :favorite_color3, :favorite_color4, :favorite_color5, :total_price).map do |vector|
            # ? 属性を設定していない場合は、0を代入
            vector.map { |element| element.nil? ? 0 : element }
        end

        # * 類似度と類似度を測定したユーザーを格納する配列
        similarities = []

        # * 類似度を計算するユーザー情報とベクトルを付与
        other_users_vectors.each_with_index do |other_users_vector, i|
            # ? 類似度を計算
            similarity = cosine_similarity(current_user_vector, other_users_vector)
            puts "ログインしている人以外のベクトル:#{other_users_vector}"

            # ? 類似度の結果とユーザー情報を配列に格納
            similarities << [other_users[i], similarity]
        end

        # * 1に近い（類似度が高い）順に並び替え
        similarities.sort_by! { |similarity| similarity[1] }.reverse!

        # * コサイン類似度の高いユーザーを表示
        @similar_users = similarities.map { |similarity| similarity[0] }

        # *** ここからデバッグ ***
        similarities.each do |similarity|
            user = similarity[0]
            similarity_score = similarity[1]
            
            puts "#{user.user_name}との類似度:#{similarity_score}"
        end

        # * コーディネートを格納する配列
        @posts = []

        # * 類似度の高いユーザ順にコーディネートを取得する
        @similar_users.each do |user|
            # ? 性別が同じユーザーから投稿を取得
            if user.gender == @user.gender
                # ? 一人のユーザーから最大5件の投稿をランダムに取得する
                user_posts = Social.where(user_id: user.id).order("RANDOM()").limit(5)

                # ? 配列に格納
                @posts.concat(user_posts)

                # ? 20件取得したら終了
                break if @posts.size >= 20
            end
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
