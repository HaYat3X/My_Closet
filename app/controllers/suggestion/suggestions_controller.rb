class Suggestion::SuggestionsController < ApplicationController
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
            @suggestions = Social.where("search LIKE ? OR search LIKE ?", key_word1, key_word2).order("RANDOM()").limit(20)

            # * おすすめのユーザを出力
            @users = User.where("tendency LIKE ? OR tendency LIKE ?", key_word1, key_word2).order("RANDOM()").limit(10)
        end

        # ! --------------追加機能の検証---------------
        # * 現在の日時から"月"を取得
        current_month = Time.now.month

        # * 作成したルールの読み込み
        if current_month = 4 or 5 or 6 or 7
            # ? 春のルールをランダムに取得
            random_number = rand(1..2).to_s
            rule = SPRING_RULES['rule_' + random_number]

            @outfit = []

            outer = Closet.where(big_Category: "アウター", user_id: current_user.id, color: rule['outer_color']).order("RANDOM()").first
            tops = Closet.where(big_Category: "トップス", user_id: current_user.id, color: rule['top_color']).order("RANDOM()").first
            pants = Closet.where(big_Category: "パンツ", user_id: current_user.id, color: rule['bottom_color']).order("RANDOM()").first

            # ? からのデータがある場合は配列自体をカラにする
            if outer.nil? || tops.nil? || pants.nil?
                @message = "アイテム数が少ないです。各カテゴリーのアイテムを追加してください。"
                @outfit = nil
            else
                @outfit << outer
                @outfit << tops
                @outfit << pants
            end
        end
    end
end
