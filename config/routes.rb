Rails.application.routes.draw do
  devise_for :users

  # ! クローゼット関連
  # * 投稿一覧取得 （root_path）
  get "closet/list", to: "coordinates/posts#list"
  # * 投稿フォーム
  get "closet/new", to: "coordinates/posts#new"
  # * 投稿処理
  post "closet/create", to: "coordinates/posts#create"
  # * 詳細画面
  get  "closet/show/:id", to: "coordinates/posts#show"
  # 削除処理
  delete "closet/delete/:id", to: "coordinates/posts#delete"
end
