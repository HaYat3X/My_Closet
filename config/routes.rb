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
  # * 編集フォーム
  get "closet/edit/:id", to: "coordinates/posts#edit"
  # * 編集処理
  patch "closet/update/:id", to: "coordinates/posts#update"
  # 検索画面
  get "closet/search", to: "coordinates/searchs#search"

  # ! SNS関連
  # * 一覧ページ
  root to: "sns/posts#list"
  # * 詳細ページ
  get "sns/show/:id", to: "sns/posts#show"
  # * 投稿ページ
  get "sns/new", to: "sns/posts#new"
  # * 投稿処理
  post "sns/create", to: "sns/posts#create"
  # * 検索処理
  get "/sns/search", to: "sns/searchs#search"
  # * 編集フォーム
  get "sns/edit/:id", to: "sns/posts#edit"
  # * 投稿編集
  patch "sns/update/:id", to: "sns/posts#update"
end
