class Suggestion::ApisController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []

    # ! API提案
    def call_gpt(user_id)
        # * ユーザ情報
        @user = User.find(user_id.to_i)
    
    
        # * GPT日クエストする文章
        request = "カジュアルスタイル、ストリートスタイル、アメカジスタイル、ルードスタイル、アウトドアスタイル、デザイナースタイル、ベーシックスタイル、モードスタイル、ラグジュアリースタイル、ガーリースタイル、ナチュラルスタイル、この中でどれか2つ身長#{@user.height}cm、体重#{@user.weight}kgの#{@user.gender}性におすすめのファッションスタイルを教えてください。"
    
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
    
        # * GPTのレスポンスから返答メッセージのみを抽出
        content = response.dig("choices", 0, "message", "content")

        # * GPTの提案から提案されたスタイルを抜き出す
        pull_out = content.scan(/カジュアルスタイル|ストリートスタイル|アメカジスタイル|ルードスタイル|アウトドアスタイル|デザイナースタイル|ベーシックスタイル|モードスタイル|ラグジュアリースタイル|ガーリースタイル|ナチュラルスタイル/)

        # * とうろく
        @suggestion = Suggest.new(user_id: @user.id, style1: pull_out[0], style2: pull_out[1])
        @suggestion.save()
    
    end

    # ! call_gptによる提案を更新する
    def call_gpt_update(user_id)
        # * ユーザ情報
        @user = User.find(user_id.to_i)


        # * 更新するデータの取得
        @suggestion = Suggest.find_by(user_id: user_id.to_i)

        # * GPT日クエストする文章
        request = "カジュアルスタイル、ストリートスタイル、アメカジスタイル、ルードスタイル、アウトドアスタイル、デザイナースタイル、ベーシックスタイル、モードスタイル、ラグジュアリースタイル、ガーリースタイル、ナチュラルスタイル、この中でどれか2つ身長#{@user.height}cm、体重#{@user.weight}kgの#{@user.gender}性におすすめのファッションスタイルを教えてください。"
    
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

        # * GPTのレスポンスから返答メッセージのみを抽出
        content = response.dig("choices", 0, "message", "content")


        # * GPTの提案から提案されたスタイルを抜き出す
        pull_out = content.scan(/カジュアルスタイル|ストリートスタイル|アメカジスタイル|ルードスタイル|アウトドアスタイル|デザイナースタイル|ベーシックスタイル|モードスタイル|ラグジュアリースタイル|ガーリースタイル|ナチュラルスタイル/)
    
        # * レスポンスを保存   
        @suggestion.update(user_id: user_id.to_i, style1: pull_out[0], style2: pull_out[1])
    end

    # ! 各ユーザーのファッションの投稿の傾向を保存する
    def call_user(user_id)
        # * 提案結果に基づいておすすめユーザを取得
            # ? 各ユーザが投稿した投稿のタグを取得する
            snss = Social.all.where(user_id: user_id)

            # ? からの配列を用意する
            my_array = []
                
            snss.each do |s|
                # ? 配列の要素数を取得
                total_elements = s.tag

                # ? 各ユーザが投稿したタグを配列に格納    
                my_array.push(s.tag)
            end
                
            # ? 配列の要素数を取得
            total_elements = my_array.length
            
            # ? 各要素の出現回数を数えるためのハッシュを作成
            counts = Hash.new(0)
            
            # ? 各要素の出現回数を数える
            my_array.each { |element| counts[element] += 1 }

            # ? 1番％が高い要素を抽出する
            max_count = counts.values.max
            most_common_elements = counts.select { |_, count| count == max_count }.keys

            # * ユーザの投稿頻度が高いタグを保存
            User.find(user_id).update(tendency: most_common_elements[0])
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
