Rails.application.routes.draw do
  get 'search/index'
  get 'search/new'
  devise_for :users

  authenticated :user do
    root to: "dashboard#index", as: :authenticated_root
    resources :search, only: [:index, :new], as: :searches
  end

  unauthenticated :user do
    root to: "home#index"
  end
end