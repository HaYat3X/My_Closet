Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # クローゼット関連
  get "closet/new", to: "coordinates/posts#new"
  post "closet/create", to: "coordinates/posts#create"
  get "closet/list", to: "coordinates/posts#list"
end
