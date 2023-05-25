class Suggestion::ApisController < ApplicationController
    # ! API提案
    def call_gpt
        # * ユーザ情報
        @user = User.find(current_user.id)
    
        # * GPT日クエストする文章
        request = "カジュアルスタイル、ストリートスタイル、アメカジスタイル、ルードスタイル、アウトドアスタイル、デザイナースタイル、ベーシックスタイル、モードスタイル、ラグジュアリースタイル、ガーリースタイル、ナチュラルスタイル、この中でどれか2つ身長#{@user.height}cm、体重#{@user.weight}kgの#{@user.gender}性におすすめのファッションスタイルを教えてください。"
    
        # * APIキーセット
        client = OpenAI::Client.new(access_token: ENV.fetch('API_KEY') { '' })
    
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
        # content = response.dig("choices", 0, "message", "content")
        content = "身長180cm、体重60kgの男性におすすめのファッションスタイルは、カジュアルスタイルとモードスタイルです。"

        # * とうろく
        @suggestion = Suggest.new(user_id: current_user.id, content: content)
    
        # * レスポンスを保存
        if @suggestion.save
            redirect_to "/suggestion"
        else
            redirect_to "/suggestion"
        end
    end
end
