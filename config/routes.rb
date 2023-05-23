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
  # * 削除処理
  delete "sns/delete/:id", to: "sns/posts#delete"
  # いいねする機能
  post "sns/create_like/:id", to:"sns/likes#create_like"
  # いいねを解除する機能
  delete "sns/delete_like/:id", to:"sns/likes#delete_like"

  # ! Q&A関連
  # * 投稿フォーム
  get "question/new", to: "faq/questions#new"
  # * 投稿処理
  post "question/create", to: "faq/questions#create"
  #　投稿一覧画面
  get "question/list", to: "faq/questions#list"
  # 詳細設定
  get "question/show/:id", to: "faq/questions#show"
  # * 投稿編集画面
  get "question/edit/:id", to: "faq/questions#edit"
  # * 投稿更新
  patch "question/update/:id", to: "faq/questions#update"
  # * 投稿削除
  delete "question/delete/:id", to: "faq/questions#delete"
  # *検索画面
  get "question/search", to: "faq/searchs#search"
end

