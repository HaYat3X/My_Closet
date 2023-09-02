class Suggestion::SuggestionsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []

    # ! 入力 => ユーザの提案情報
    # ! 加工 => 提案情報に基づいてコーディネートを取得する
    # ! 出力 => SNSのコーディネート20件
    def suggestion
        # * 提案する
        @suggest = Suggest.new()

        # * AIによる提案情報が存在するか判定
        if Suggest.exists?(user_id: current_user.id)
            other_users_suggest = Suggest.where.not(user_id: current_user.id)
            user_suggest = Suggest.find_by(user_id: current_user.id)
            current_user_gender = User.find(current_user.id).gender

            # * レコメンドでおすすめコーデを取得する
            @recommend = recommend(current_user_gender, user_suggest, other_users_suggest)

            # * パーソナルカラーと好きなコーデによって表示する画像を返す
            case personal_color = user_suggest.personal_color
            when personal_color === "春 (Spring)"
                @pc_img_path = "/assets/suggest/pc_spring.png"
                @mobile_img_path = "/assets/suggest/mobile_spring.png"
                @tablet_img_path = "/assets/suggest/tablet_spring.png"
                
                if current_user_gender == 1
                    @suggest_imgs = ["/assets/suggest/test3.png", "/assets/suggest/test3.png", "/assets/suggest/test3.png", "/assets/suggest/test3.png"]
                else
                    @suggest_imgs = ["/assets/suggest/test3.png", "/assets/suggest/test3.png", "/assets/suggest/test3.png", "/assets/suggest/test3.png"]
                end
            when personal_color === "夏 (Summer)"
                @pc_img_path = "/assets/suggest/pc_summer.png"
                @mobile_img_path = "/assets/suggest/mobile_summer.png"
                @tablet_img_path = "/assets/suggest/tablet_summer.png"

                if current_user_gender == 1
                    @suggest_imgs = ["/assets/suggest/test3.png", "/assets/suggest/test3.png", "/assets/suggest/test3.png", "/assets/suggest/test3.png"]
                else
                    @suggest_imgs = ["/assets/suggest/test3.png", "/assets/suggest/test3.png", "/assets/suggest/test3.png", "/assets/suggest/test3.png"]
                end
            when personal_color === "秋 (Autumn)"
                @pc_img_path = "/assets/suggest/pc_autumn.png"
                @mobile_img_path = "/assets/suggest/mobile_autumn.png"
                @tablet_img_path = "/assets/suggest/tablet_autumn.png"

                if current_user_gender == 1
                    @suggest_imgs = ["/assets/suggest/test3.png", "/assets/suggest/test3.png", "/assets/suggest/test3.png", "/assets/suggest/test3.png"]
                else
                    @suggest_imgs = ["/assets/suggest/test3.png", "/assets/suggest/test3.png", "/assets/suggest/test3.png", "/assets/suggest/test3.png"]
                end
            else 
                @pc_img_path = "/assets/suggest/pc_winter.png"
                @mobile_img_path = "/assets/suggest/mobile_winter.png"
                @tablet_img_path = "/assets/suggest/tablet_winter.png"

                if current_user_gender == 1
                    @suggest_imgs = ["/assets/suggest/test3.png", "/assets/suggest/test3.png", "/assets/suggest/test3.png", "/assets/suggest/test3.png"]
                else
                    @suggest_imgs = ["/assets/suggest/test3.png", "/assets/suggest/test3.png", "/assets/suggest/test3.png", "/assets/suggest/test3.png"]
                end
            end

            # * デバッグ
            puts "ログインしているユーザー：#{user_suggest.personal_color}"
            
            other_users_suggest.each do |single|
                puts "ログインしている以外のユーザー：#{single.personal_color}"
            end
        end
    end

    # ! ユーザの好みを決定する
    def suggest_create
        @user = User.find(current_user.id)
        @suggest = Suggest.new(posts_params)

        @suggest.user_id = current_user.id

        # * ログインしているユーザ以外のユーザ情報を取得    
        if @suggest.save
            # * GPTリクエスト
            call_gpt(current_user.id)
        else
            render :suggestion
        end
    end

    # ! 始めて提案するユーザーのために、提案画面へ誘導する
    def induction
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
        # * suggestモデルにバインドする
        params.require(:suggest).permit(:eye_color, :hair_color, :skin_color, :size, :style1, :style2, :style3, :total_price)
    end

    # ! GPTにリクエストする
    def call_gpt(user_id)
        # * ユーザーの設定した好みを取得する
        suggest = Suggest.find_by(user_id: user_id.to_i)

        # * GPT日クエストする文章
        request = "
            ##Instruction##
            パーソナルカラー診断を行ってください。
            
            ##Input##
            瞳の色が#{suggest.eye_color}色、髪の色が#{suggest.hair_color}色、肌の色が#{suggest.skin_color}色の人のパーソナルカラーを診断をしてください。
            
            ##Context##
            パーソナルカラーは以下の4つと定義します。
            1. 春 (Spring)：明るく温かみのある色
            2. 夏 (Summer): やわらかなパステルカラーやクールな色
            3. 秋 (Autumn): 温かみのある濃い色
            4. 冬 (Winter): 鮮やかでクリアな色
            
            ##Output##
            回答は、
            1、春 (Spring)
            2、夏 (Summer)
            3、秋 (Autumn)
            4、冬 (Winter) 
            いずれかのみで回答してください。
            解説なしで端的に結果だけ教えてください。
        "
            
        # * APIキーセット
        client = OpenAI::Client.new(access_token: ENV['GPT_ACCESS_KEY'])
            
        # * GPTのレスポンス 
        response = client.chat(
            parameters: {
                # ? 使用するGPTのエンジンを指定
                model: "gpt-3.5-turbo",
                
                # ? レスポンスの形式を指定
                messages: [{ role: "system", content: "You are a helpful assistant. response to japanese" }, { role: "user", content: request }],
                    
                # ? 応答のランダム性と最大文字数を指定
                temperature: 0,
                max_tokens: 200,
            },
        )
        
        if response['error']
            # エラーに対する処理を行う
            puts "GPT APIエラー：#{response['error']['message']}"

            # ? 提案に失敗したら、好みのデータを消す
            suggest.delete() 

            # 例：エラーが発生した場合、デフォルトの提案ページにリダイレクトする
            redirect_to "/suggestion", alert: "AI提案に失敗しました。もう一度お試しください。"
        else
            # * GPTのレスポンスから返答メッセージのみを抽出
            content = response.dig("choices", 0, "message", "content")
            puts "レスポンス：#{content}"
        
            # * GPTの提案から提案されたスタイルを抜き出す
            pull_out = content.match(/(春|夏|秋|冬) \((Spring|Summer|Autumn|Winter)\)/).to_s

            if pull_out.nil? || pull_out.empty?
                pull_out = "夏 (Summer)"
            end

            puts "パーソナルカラー：#{pull_out}"

            # * 提案の成功、失敗によって設定したURLにフラッシュメッセージを変更し出力する
            if suggest.update(personal_color: pull_out)
                redirect_to "/suggestion", notice: "AI提案した。"
            else
                redirect_to "/suggestion", alert: "AI提案に失敗しました。もう一度お試しください。"
            end
        end
    end

    # !  レコメンドする
    def recommend(user_gender, user, other_users)
        # * ログインしているユーザーのベクトルを作成
        user_vector = [
            # ? 属性を設定していない場合は、0を代入
            user.size.nil? ? 0 : user.size.to_i,
            user.style1.nil? ? 0 : user.style1.to_i,
            user.style2.nil? ? 0 : user.style2.to_i,
            user.style3.nil? ? 0 : user.style3.to_i,
            user.total_price.nil? ? 0 : user.total_price.to_i,
        ]

        puts "ユーザーのベクトル => #{user_vector}"

        other_users_vectors = other_users.pluck(:size, :style1, :style2, :style3, :total_price).map do |vector|
            vector.map! { |element| element.nil? ? 0 : element.to_i }
        
            puts "ユーザー以外のベクトル => #{vector}"
        
            vector
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

        similarities.each do |similarity|
            puts "ユーザーID：#{similarity[0].user_id}との類似度：#{similarity[1]}"
        end

        # * コサイン類似度の高いユーザーを表示
        similar_users = similarities.map { |similarity| similarity[0] }

        # * コーディネートを格納する配列
        posts = []

        similar_users.each do |other_user|
            # ? 性別が同じかつ類似度か高いユーザーから投稿を取得
            user_posts = Social.joins(:user).where(users: { gender: user_gender, id: other_user.user_id }).order("RANDOM()").limit(1)

            # ? 4件投稿が集まるまで取得
            if user_posts.length <= 4
                posts.concat(user_posts)
            end
        end

        puts "取得した投稿=> #{posts}"

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
