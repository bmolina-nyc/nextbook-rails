Rails.application.routes.draw do

  resource :demos, only: :create

  namespace :v1 do
    namespace :books do
      resources :recommendations, only: %i(index)
      resources :my_books, only: %i(index)
      namespace :my_books do
        resources :liked, :disliked, :already_read, :want_to_read, only: :index
      end
    end
    namespace :user_books do
      resource :counts, only: :show, controller: 'counts'
      resource :for_ids, only: :show, controller: 'for_ids'
    end
    resource  :searches, only: %i(show)
    resources :books, only: %i(index show)
    resource :user, only: %i(create show update destroy)
    resources :user_books, param: :google_id, only: %i(index show create update destroy)
    resource :sessions, only: %i(create show destroy)
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
