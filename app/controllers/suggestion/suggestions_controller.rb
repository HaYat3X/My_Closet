class Suggestion::SuggestionsController < ApplicationController
    # ! GPTによる提案
    def suggestion
        # * ユーザ情報
        @user = User.find(current_user.id)

        # * 提案情報があるかないか判定
        if Suggest.exists?(user_id: current_user.id)
            suggestion = Suggest.find_by(user_id: current_user.id)

            # pp suggestion
            key_word1 = '%' + suggestion.style1 + '%'
            key_word2 = '%' + suggestion.style2 + '%'

            # * SNSの投稿データを返す（大文字と小文字を区別しない）
            @suggestions = Social.where("search LIKE ? OR search LIKE ?", key_word1, key_word2).order("RANDOM()").limit(20)

            # * おすすめのユーザを出力
            @users = User.where("tendency LIKE ? OR tendency LIKE ?", key_word1, key_word2).order("RANDOM()").limit(10)
        end
    end
end
