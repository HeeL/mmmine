Mmmine::Application.routes.draw do

  devise_for :users, skip: :sessions, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  match '/more' => 'pages#more', as: :more
  post  '/reports/create' => 'reports#create', as: :report_create

  match '/users/sign_in' => redirect('/')
  match '/users/sign_out' => 'users#logout', as: :logout
  match '/users/register' => 'users#register', as: :register
  match '/users/login' => 'users#login', as: :login
  match '/users/change_password' => 'users#change_password', as: :change_password

  devise_scope :user do
    match '/products/create' => 'products#create', as: :product_create
    match '/products/comment_create' => 'products#comment_create', as: :comment_create
    get '/users/auth/:provider/callback' => 'users/omniauth_callbacks#passthru'
    match '/profile/edit' => 'users#edit', as: :edit_profile, via: [:get, :put]
  end

  root :to => 'products#index'

end
