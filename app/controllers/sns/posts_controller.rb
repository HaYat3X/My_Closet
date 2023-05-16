class Sns::PostsController < ApplicationController
    # ! 一覧取得メソッド
    def list
        @snss = Social.all
    end    

    # ! 詳細取得メソッド
    def show
        # * 詳細情報を一件取得する
        @sns = Social.find(1)

        # * item1〜6の情報を取得する
        @item1 = Closet.find_by(id: @sns.item1)
        @item2 = Closet.find_by(id: @sns.item2)
        @item3 = Closet.find_by(id: @sns.item3)
        @item4 = Closet.find_by(id: @sns.item4)
        @item5 = Closet.find_by(id: @sns.item5)
        @item6 = Closet.find_by(id: @sns.item6)
    end    
end
