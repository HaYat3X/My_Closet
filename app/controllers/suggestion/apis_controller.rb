class Suggestion::ApisController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []

    # ! API提案
    def call_gpt
        if current_user.gender == 1
            gender = "男性"
        else
            gender = "女性"
        end

    
        # * GPT日クエストする文章
        request = "カジュアルスタイル、ストリートスタイル、アメカジスタイル、ルードスタイル、アウトドアスタイル、デザイナースタイル、ベーシックスタイル、モードスタイル、ラグジュアリースタイル、ガーリースタイル、ナチュラルスタイル、この中でどれか2つ身長#{current_user.height}cm、体重#{current_user.weight}kgの#{gender}におすすめのファッションスタイルを教えてください。"

        puts "リクエスト文 => #{request}"
    
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
            # 例：エラーが発生した場合、デフォルトの提案ページにリダイレクトする
            redirect_to "/suggestion", alert: "AI提案に失敗しました。もう一度お試しください。"
        else
            # * GPTのレスポンスから返答メッセージのみを抽出
            content = response.dig("choices", 0, "message", "content")

            # * GPTの提案から提案されたスタイルを抜き出す
            pull_out = content.scan(/カジュアルスタイル|ストリートスタイル|アメカジスタイル|ルードスタイル|アウトドアスタイル|デザイナースタイル|ベーシックスタイル|モードスタイル|ラグジュアリースタイル|ガーリースタイル|ナチュラルスタイル/)

            # * とうろく
            suggestion = Suggest.new(user_id: current_user.id, style1: pull_out[0], style2: pull_out[1])

            # * 提案の成功、失敗によって設定したURLにフラッシュメッセージを変更し出力する
            if suggestion.save
                redirect_to "/suggestion", notice: "AI提案した。"
            else
                redirect_to "/suggestion", alert: "AI提案に失敗しました。もう一度お試しください。"
            end
        end
    end

    # ! call_gptによる提案を更新する
    def call_gpt_update
        suggestion = Suggest.find_by(user_id: current_user.id)

        # * 1週間に一度しか提案させない
        if (Time.now - suggestion.created_at) >= 1.week
            if current_user.gender == 1
                gender = "男性"
            else
                gender = "女性"
            end
    
        
            # * GPT日クエストする文章
            request = "カジュアルスタイル、ストリートスタイル、アメカジスタイル、ルードスタイル、アウトドアスタイル、デザイナースタイル、ベーシックスタイル、モードスタイル、ラグジュアリースタイル、ガーリースタイル、ナチュラルスタイル、この中でどれか2つ身長#{current_user.height}cm、体重#{current_user.weight}kgの#{gender}におすすめのファッションスタイルを教えてください。"
    
            puts "リクエスト文 => #{request}"
        
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
                # 例：エラーが発生した場合、デフォルトの提案ページにリダイレクトする
                redirect_to "/suggestion", alert: "AI提案に失敗しました。もう一度お試しください。"
            else
                # * GPTのレスポンスから返答メッセージのみを抽出
                content = response.dig("choices", 0, "message", "content")
    
                # * GPTの提案から提案されたスタイルを抜き出す
                pull_out = content.scan(/カジュアルスタイル|ストリートスタイル|アメカジスタイル|ルードスタイル|アウトドアスタイル|デザイナースタイル|ベーシックスタイル|モードスタイル|ラグジュアリースタイル|ガーリースタイル|ナチュラルスタイル/)
    
                # * 更新処理の成功、失敗によって設定したURLにフラッシュメッセージを変更し出力する
                if suggestion.update(user_id: current_user.id, style1: pull_out[0], style2: pull_out[1])
                    redirect_to "/suggestion", notice: "AI提案した。"
                else
                    redirect_to "/suggestion", alert: "AI提案に失敗しました。もう一度お試しください。"
                end
            end
        else
            redirect_to "/suggestion", alert: "AI提案は、1週間に一度しか実行できません。"
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
