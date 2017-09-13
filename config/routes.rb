Rails.application.routes.draw do

  namespace :v1 do
    resources :users, only: %i(create show update destroy)
    resources :user_books, only: %i(index show create update destroy)
    resource :sessions, only: %i(create show destroy)
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
