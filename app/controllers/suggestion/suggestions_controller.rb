class Suggestion::SuggestionsController < ApplicationController
    # ! GPTによる提案
    def suggestion
        # ? 1、ユーザは必要な情報をすべて入力している？
        # * ユーザ情報
        @user = User.find(current_user.id)

        # * 提案情報があるかないか判定
        if Suggest.exists?(user_id: current_user.id)
            suggestion = Suggest.find_by(user_id: current_user.id)

            # * GPTの提案から提案されたスタイルを抜き出す
            style = suggestion.content.to_s
            pull_out = style.scan(/カジュアルスタイル|ストリートスタイル|アメカジスタイル|ルードスタイル|アウトドアスタイル|デザイナースタイル|ベーシックスタイル|モードスタイル|ラグジュアリースタイル|ガーリースタイル|ナチュラルスタイル/)

            # * 抜き出した結果を出力する
            # puts pull_out[0]
            # puts pull_out[1]

            # *　提案結果からSNS投稿を取得
            key_word1 = '%' + pull_out[0] + '%'
            key_word2 = '%' + pull_out[1] + '%'

            # * 検索（大文字と小文字を区別しない）
            @suggestions = Social.where("search LIKE ? OR search LIKE ?", key_word1, key_word2)
        end
    end
end
