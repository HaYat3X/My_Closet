Rails.application.routes.draw do
  # ! 管理者関連の認証
  devise_for :admins

  # ! ユーザ関連の認証
  devise_for :users

  # ! SNS画面のルーティング
  root to: "sns/posts#list"
  get "sns/show/:id", to: "sns/posts#show"
  get "sns/new", to: "sns/posts#new"
  post "sns/create", to: "sns/posts#create"
  get "sns/edit/:id", to: "sns/posts#edit"
  patch "sns/update/:id", to: "sns/posts#update"
  delete "sns/delete/:id", to: "sns/posts#delete"
  get "/sns/search", to: "sns/searchs#search"
  post "sns/create_like/:id", to:"sns/likes#create_like"
  delete "sns/delete_like/:id", to:"sns/likes#delete_like"
  get "sns/like_ranking", to: "sns/likes#like_ranking"

  # ! クローゼット画面のルーティング
  get "closet/list", to: "coordinates/posts#list"
  get "closet/new", to: "coordinates/posts#new"
  post "closet/create", to: "coordinates/posts#create"
  get  "closet/show/:id", to: "coordinates/posts#show"
  delete "closet/delete/:id", to: "coordinates/posts#delete"
  get "closet/edit/:id", to: "coordinates/posts#edit"
  patch "closet/update/:id", to: "coordinates/posts#update"
  get "closet/search", to: "coordinates/searchs#search"
  post "/realtime_selected_value", to: "coordinates/posts#realtime_selected_value"


  

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
  patch "call_gpt_update", to: "suggestion/apis#call_gpt_update"
  # * ユーザーの好みを判定する
  post "user_like_create", to: "suggestion/apis#user_like_create"

  # ! プロフィール画面のルーティング
  get "profile/show/:id", to: "profile/profiles#show"
  get "profile/edit/:id", to: "profile/profiles#edit"
  patch "profile/update/:id", to: "profile/profiles#update"
  post "profile/follow/:id", to: "profile/follows#create_follow"
  delete "profile/follow/:id", to: "profile/follows#delete_follow"
  get "follow_list/:id", to: "profile/follows#follow_list"
  get "follower_list/:id", to: "profile/follows#follower_list"
  get "alert/list", to: "profile/alerts#list"
  get "alert/show/:id", to: "profile/alerts#show"
  
  #お問い合わせフォーム
  get "contact/new" , to: "contact/contacts#new"
  post "contact/create" , to: "contact/contacts#create"
  get "contact/complete" , to: "contact/contacts#complete"

  # ! 管理者関連
  # * お知らせ登録フォーム
  get "admin/alert/new", to: "admin/alerts#new"
  post "admin/alert/create", to: "admin/alerts#create"
  get "admin/alert/list", to: "admin/alerts#list"
  get "admin/alert/show/:id", to: "admin/alerts#show"
  get "admin/alert/edit/:id", to: "admin/alerts#edit"
  patch "admin/alert/update/:id", to: "admin/alerts#update"
  delete "admin/alert/delete/:id", to: "admin/alerts#delete"

  # ! お問い合わせ関連（管理者）
  get "admin/contact/list", to: "admin/contacts#list"
  get "admin/contact/show/:id", to: "admin/contacts#show"
  post "admin/contact/create_handle/:id", to: "admin/contacts#create_handle"
  post "admin/contact/delete_handle/:id", to: "admin/contacts#delete_handle"
end

