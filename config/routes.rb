Rails.application.routes.draw do

  namespace :v1 do
    resources :recommendations, only: %i(index)
    resource :books, only: %i(show)
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
