class Suggestion::ApisController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []

    # ! API提案
    def call_gpt(user_id)
        # * ユーザ情報
        @user = User.find(user_id.to_i)

        # * ユーザの身長、体重、性別が存在しない場合は、提案をしない
        if @user.weight and @user.height and @user.gender == ""
            return { redirect_url: "/profile/show/#{@user.id}", flash_message: "AI提案が失敗しました。", flash: "alert" }
        end
    
        # * GPT日クエストする文章
        request = "カジュアルスタイル、ストリートスタイル、アメカジスタイル、ルードスタイル、アウトドアスタイル、デザイナースタイル、ベーシックスタイル、モードスタイル、ラグジュアリースタイル、ガーリースタイル、ナチュラルスタイル、この中でどれか2つ身長#{@user.height}cm、体重#{@user.weight}kgの性別：#{@user.gender}におすすめのファッションスタイルを教えてください。"
    
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

        # # * GPTのレスポンスがnullだった場合アラートを出力する
        if response == nil
            return { redirect_url: "/profile/show/#{@user.id}", flash_message: "AI提案が失敗しました。" }
        end

    
        # * GPTのレスポンスから返答メッセージのみを抽出
        content = response.dig("choices", 0, "message", "content")

        

        # * GPTの提案から提案されたスタイルを抜き出す
        pull_out = content.scan(/カジュアルスタイル|ストリートスタイル|アメカジスタイル|ルードスタイル|アウトドアスタイル|デザイナースタイル|ベーシックスタイル|モードスタイル|ラグジュアリースタイル|ガーリースタイル|ナチュラルスタイル/)

        # * とうろく
        @suggestion = Suggest.new(user_id: @user.id, style1: pull_out[0], style2: pull_out[1])

        # * 提案の成功、失敗によって設定したURLにフラッシュメッセージを変更し出力する
        if @suggestion.save()
            return { redirect_url: "/profile/show/#{@user.id}", flash_message: "AI提案が実行されました。",
            flash: "notice" }
        else
            return { redirect_url: "/profile/show/#{@user.id}", flash_message: "AI提案が失敗しました。", flash: "alert" }
        end
    end

    # ! call_gptによる提案を更新する
    def call_gpt_update(user_id)
        # * ユーザ情報
        @user = User.find(user_id.to_i)

        # * ユーザの身長、体重、性別が存在しない場合は、提案をしない
        if @user.weight and @user.height and @user.gender == nil
            return { redirect_url: "/profile/show/#{@user.id}", flash_message: "AI提案が失敗しました。", flash: "alert" }
        end

        # * 更新するデータの取得
        @suggestion = Suggest.find_by(user_id: user_id.to_i)

        # * GPT日クエストする文章
        request = "カジュアルスタイル、ストリートスタイル、アメカジスタイル、ルードスタイル、アウトドアスタイル、デザイナースタイル、ベーシックスタイル、モードスタイル、ラグジュアリースタイル、ガーリースタイル、ナチュラルスタイル、この中でどれか2つ身長#{@user.height}cm、体重#{@user.weight}kgの性別：#{@user.gender}におすすめのファッションスタイルを教えてください。"

        # * APIキーセット
        client = OpenAI::Client.new(access_token: ENV['GPT_ACCESS_KEY'] )

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

        # # * GPTのレスポンスがnullだった場合アラートを出力する
        if response == nil
            return { redirect_url: "/profile/show/#{@user.id}", flash_message: "AI提案が失敗しました。", flash: "alert" }
        end


        # * GPTのレスポンスから返答メッセージのみを抽出
        content = response.dig("choices", 0, "message", "content")


        # * GPTの提案から提案されたスタイルを抜き出す
        pull_out = content.scan(/カジュアルスタイル|ストリートスタイル|アメカジスタイル|ルードスタイル|アウトドアスタイル|デザイナースタイル|ベーシックスタイル|モードスタイル|ラグジュアリースタイル|ガーリースタイル|ナチュラルスタイル/)
    
        # * 更新処理の成功、失敗によって設定したURLにフラッシュメッセージを変更し出力する
        if @suggestion.update(user_id: user_id.to_i, style1: pull_out[0], style2: pull_out[1])
            return { redirect_url: "/profile/show/#{@user.id}", flash_message: "AI提案が実行されました。", flash: "notice" }
        else
            return { redirect_url: "/profile/show/#{@user.id}", flash_message: "AI提案が失敗しました。", flash: "alert" }
        end
        
    end

    # ! ユーザーの特徴量を取得して、保存する
    def user_like_create
        # * 送信された値を受け取る
        size = params[:size]
        favorite_color1 = params[:favorite_color1]
        favorite_color2 = params[:favorite_color2]
        favorite_color3 = params[:favorite_color3]
        favorite_color4 = params[:favorite_color4]
        favorite_color5 = params[:favorite_color5]
        total_price = params[:total_price]

        user = User.find(current_user.id)
        
        if user.update(size: size, favorite_color1: favorite_color1,favorite_color2: favorite_color2, favorite_color3: favorite_color3, favorite_color4: favorite_color4, favorite_color5: favorite_color5, total_price: total_price)
            redirect_to request.referer, notice: "好みを設定しました。"
        else
            redirect_to request.referer, alert: "好みを設定に失敗しました。"
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
end
