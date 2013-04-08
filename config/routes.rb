Mmmine::Application.routes.draw do

  devise_for :users, skip: :sessions, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  match 'users/sign_in' => redirect('/')
  match 'users/sign_out' => 'users#logout', as: :logout
  match 'users/register' => 'users#register', as: :register
  match 'users/login' => 'users#login', as: :login

  devise_scope :user do
    get '/users/auth/:provider/callback' => 'users/omniauth_callbacks#passthru'
    match 'profile/edit' => 'users#edit', as: :edit_profile, via: [:get, :put]
  end


  root :to => 'pages#index'

end
