class Sns::SearchsController < ApplicationController
    # ! ログインが必要ないメソッドを記述する (ログインが必要なメソッドは書かない)
    before_action :move_to_signed_in, except: [:search]

    # ! 検索フォームに入力されているキーワードを元に、SNSテーブルの情報を検索するメソッド
    def search
        # * 入力フォームの値を受け取る
        key_word = params[:search]
        current_year = Time.current.year

        # キーワードと期間の対応関係を定義
        seasons = {
            "春" => [3, 5],
            "夏" => [6, 8],
            "秋" => [9, 11],
            "冬" => [12, 2]
        }

        # キーワードに基づいて期間を設定
        if seasons.key?(key_word)
            start_month, end_month = seasons[key_word]

            # start_dateを設定
            start_date = Time.new(current_year, start_month, 1, 0, 0, 0, '+00:00')

            # end_dateを設定
            if end_month > 12
                end_date = Time.new(current_year + 1, end_month - 12, 1, 0, 0, 0, '+00:00').end_of_month
            else
                end_date = Time.new(current_year, end_month, 1, 0, 0, 0, '+00:00').end_of_month
            end

            @search_result = Social.where(created_at: start_date..end_date).page(params[:page]).per(48)
        else
        # キーワードが不正な場合の処理
        # 例えばエラーメッセージの表示などを行う
        end
        current_year = Time.current.year

        if key_word === "春"
            # start_dateを設定
            start_date = Time.new(current_year, 3, 1, 0, 0, 0, '+00:00')

            # end_dateを設定
            end_date = Time.new(current_year, 5, 31, 23, 59, 59, '+00:00')

            @search_result = Social.where(created_at: start_date..end_date).page(params[:page]).per(48)
        elsif key_word === "夏"
            # start_dateを設定
            start_date = Time.new(current_year, 6, 1, 0, 0, 0, '+00:00')

            # end_dateを設定
            end_date = Time.new(current_year, 8, 31, 23, 59, 59, '+00:00')

            @search_result = Social.where(created_at: start_date..end_date).page(params[:page]).per(48)
        elsif key_word === "秋"
            # start_dateを設定
            start_date = Time.new(current_year, 9, 1, 0, 0, 0, '+00:00')

            # end_dateを設定
            end_date = Time.new(current_year, 11, 31, 23, 59, 59, '+00:00')

            @search_result = Social.where(created_at: start_date..end_date).page(params[:page]).per(48)
        elsif key_word === "冬"
            # start_dateを設定
            start_date = Time.new(current_year, 12, 1, 0, 0, 0, '+00:00')

            # end_dateを設定
            end_date = Time.new(current_year, 2, 31, 23, 59, 59, '+00:00')

            @search_result = Social.where(created_at: start_date..end_date).page(params[:page]).per(48)
        else
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
