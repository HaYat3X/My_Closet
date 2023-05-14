Rails.application.routes.draw do
  devise_for :users

  # ! クローゼット関連
  # * 投稿一覧取得 （root_path）
  root to: "coordinates/posts#list"
  # * 投稿フォーム
  get "closet/new", to: "coordinates/posts#new"
  # * 投稿処理
  post "closet/create", to: "coordinates/posts#create"
end
