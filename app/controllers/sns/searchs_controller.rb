class Sns::SearchsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: [:search]

    # ! 検索フォームに入力されているキーワードを元に、SNSテーブルの情報を検索するメソッド
    def search
        # * 入力されたキーワードを受け取る
        key_word = params[:search]

        # * 季節の検索時に使用するために、現在の月を取得
        current_year = Time.current.year

        # * 入力されたキーワードと期間の対応関係を定義
        seasons = {
            "春" => [3, 5],
            "夏" => [6, 8],
            "秋" => [9, 11],
            "冬" => [12, 2]
        }

        # * 入力されたキーワードと身長の対応関係を定義
        height = {
            "~149" => [0, 149],
            "150~159" => [150, 159],
            "160~170" => [160, 170],
            "175~" => [175, 300]
        }

        # * 指定されたキーワードに基づいて検索
        if seasons.key?(key_word)
            # ? 開始日と終了日を定義
            start_month, end_month = seasons[key_word]

            # ? start_dateを設定
            start_date = Time.new(current_year, start_month, 1, 0, 0, 0, '+00:00')

            # ? end_dateを設定
            if end_month > 12
                end_date = Time.new(current_year + 1, end_month - 12, 1, 0, 0, 0, '+00:00').end_of_month
            else
                end_date = Time.new(current_year, end_month, 1, 0, 0, 0, '+00:00').end_of_month
            end

            # ? 検索結果を変数に格納
            @search_result = Social.where(created_at: start_date..end_date).page(params[:page]).per(48)
        elsif height.key?(key_word)
            # ? 身長の最大値と最小値を定義
            min_height, max_height = height[key_word]

            # ? 検索結果を変数に格納
            @search_result = Social.joins(:user).where(users: { height: min_height..max_height }).page(params[:page]).per(48)
        else
            # ? 入力されたキーワードが指定した値以外の時は、入力されたキーワードで曖昧検索
            @search_result = search_social('%' + key_word + '%').page(params[:page]).per(48)
        end
    end

    private

    # ! サインインしているのか判定する
    def move_to_signed_in
        unless user_signed_in?
            redirect_to new_user_session_path, alert: "この操作は、ログインが必要です。"
        end
    end

    # ! 与えられた検索キーワードに部分一致するSNSレコードを検索するメソッド
    def search_social(key_word)
        # * 検索キーワードに部分一致するSNSレコードを検索する
        Social.where("LOWER(search) LIKE ?", key_word.downcase)
    end
end
