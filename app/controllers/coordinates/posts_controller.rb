class Coordinates::PostsController < ApplicationController
    # 登録フォーム用メソッド
    def new
        # * 使用するモデルの定義
        @closet = Closet.new
    end

     # 登録処理用メソッド
    def create
        closet = Closet.new(create_params)
        # user_idを保存
        closet.user_id = current_user.id

        closet.save
    end

    private

    # 投稿時にバインドするパラメータ
    def create_params
        params.require(:closet).permit(:photograph, :big_Category, :small_Category, :price, :color, :size, :brand)
    end
end
