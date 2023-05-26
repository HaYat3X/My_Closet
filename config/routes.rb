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
  # * 投稿一覧画面
  get "question/list", to: "faq/questions#list"
  # * 詳細設定
  get "question/show/:id", to: "faq/questions#show"
  # * 投稿編集画面
  get "question/edit/:id", to: "faq/questions#edit"
  # * 投稿更新
  patch "question/update/:id", to: "faq/questions#update"
  # * 投稿削除
  delete "question/delete/:id", to: "faq/questions#delete"
  # * 検索画面
  get "question/search", to: "faq/searchs#search"
  # * 回答投稿処理 
  post "faq/answer/create/:id", to: "faq/answers#create"
  # * 回答削除
  delete "faq/answer/delete/:id", to: "faq/answers#delete"
  # * 回答編集画面
  get "faq/answer/edit/:id", to: "faq/answers#edit"
  # * 回答更新
  patch "faq/answer/update/:id", to: "faq/answers#update"

  # * いいね機能
  post "faq/create_like/:id", to: "faq/likes#create_like"
  # * いいねを解除する機能
  delete "faq/create_delete/:id", to: "faq/likes#delete_like"

  # ! 提案関連
  # * 提案ページ
  get "suggestion", to: "suggestion/suggestions#suggestion"
  # * apiのコール
  post "call_gpt", to: "suggestion/apis#call_gpt"
  # * 各ユーザーのファッションの投稿の傾向を保存する
  post "call_user", to: "suggestion/apis#call_user"
  # * call_gptによる提案を更新する
  post "call_gpt_update", to: "suggestion/apis#call_gpt_update"

  # ! プロフィール関連
  # * プロフィールページ
  get "profile/show", to: "profile/profiles#show"
  # * プロフィール更新ページ
  get "profile/edit", to: "profile/profiles#edit"
  # * プロフィール更新
  patch "profile/update", to: "profile/profiles#update"
end

