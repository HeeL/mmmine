Mmmine::Application.routes.draw do

  root :to => 'products#index'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users, skip: :sessions, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  match '/more' => 'pages#more', as: :more
  post  '/reports/create' => 'reports#create', as: :report_create

  match '/users/sign_in' => redirect('/')
  match '/users/sign_out' => 'users#logout', as: :logout
  match '/users/register' => 'users#register', as: :register
  match '/users/login' => 'users#login', as: :login
  match '/users/change_password' => 'users#change_password', as: :change_password
  match '/categories/subcategories/:id' => 'categories#sub_cats'

  devise_scope :user do
    match '/products/live_feed' => 'products#live_feed', as: :live_feed
    match '/products/top_stores' => 'products#top_stores', as: :top_stores
    match '/products/buy/:id' => 'products#buy', as: :product_buy
    match '/products/create' => 'products#create', as: :product_create
    match '/products/destroy/:id' => 'products#destroy', as: :product_destroy
    match '/comments/create' => 'comments#create', as: :comment_create
    match '/comments/:id/destroy' => 'comments#destroy', as: :comment_destroy
    match '/users/follow' => 'users#follow', as: :follow
    match '/products/follow/:id' => 'products#follow', as: :follow_product
    match '/products/share/:id' => 'products#share', as: :share_product
    get '/users/auth/:provider/callback' => 'users/omniauth_callbacks#passthru'
    match '/profile/edit' => 'users#edit', as: :edit_profile, via: [:get, :put]
    match '/profile/show(/:id)' => 'users#show', as: :show_profile
    post '/users/mark_viewed_notification' => 'users#mark_viewed_notification'
  end

  match  '/products' => 'products#index', as: :product_list
  match  '/users/match_names' => 'users#match_names'

end
