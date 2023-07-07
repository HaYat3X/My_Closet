class Suggestion::SuggestionsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: []

    # ! GPTによる提案
    def suggestion
        # * ユーザ情報
        @user = User.find(current_user.id)

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
