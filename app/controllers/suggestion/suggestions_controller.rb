class Suggestion::SuggestionsController < ApplicationController
    # ! GPTによる提案
    def suggestion
        # * ユーザ情報
        @user = User.find(current_user.id)

        # * 提案情報があるかないか判定
        if Suggest.exists?(user_id: current_user.id)
            suggestion = Suggest.find_by(user_id: current_user.id)

            # * GPTの提案から提案されたスタイルを抜き出す
            style = suggestion.content.to_s
            pull_out = style.scan(/カジュアルスタイル|ストリートスタイル|アメカジスタイル|ルードスタイル|アウトドアスタイル|デザイナースタイル|ベーシックスタイル|モードスタイル|ラグジュアリースタイル|ガーリースタイル|ナチュラルスタイル/)

            # *　提案結果からSNS投稿を検索、提案されたスタイルを抜き出す
            key_word1 = '%' + pull_out[0] + '%'
            key_word2 = '%' + pull_out[1] + '%'

            # * SNSの投稿データを返す（大文字と小文字を区別しない）
            @suggestions = Social.where("search LIKE ? OR search LIKE ?", key_word1, key_word2).limit(20)

            # * おすすめのユーザを出力
            @users = User.where("tendency LIKE ? OR tendency LIKE ?", key_word1, key_word2).limit(20)
        end
    end

    # ! ユーザによる提案
    def user_suggestion
        # * 提案結果に基づいておすすめユーザを取得
        # ? 1、全ユーザを取得
        users = User.all()

        users.each do |u|
            # ? 各ユーザが投稿した投稿のタグを取得する
            snss = Social.all.where(user_id: u.id)

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
            if u.update(tendency: most_common_elements[0])
                redirect_to "/suggestion"
            else
                redirect_to "/"
            end
        end
    end
end
