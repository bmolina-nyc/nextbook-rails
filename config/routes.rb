Rails.application.routes.draw do

  namespace :v1 do
    namespace :books do
      resources :recommendations, only: %i(index)
      resources :my_books, only: %i(index)
    end
    resource  :searches, only: %i(show)
    resources :books, only: %i(index show)
    resources :users, only: %i(create show update destroy)
    resources :user_books, only: %i(index show create update destroy)
    resource :sessions, only: %i(create show destroy)
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
