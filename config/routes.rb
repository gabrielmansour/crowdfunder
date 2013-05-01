Crowdfunder::Application.routes.draw do
  resources :projects do
    resources :pledges
  end

  resources :users

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  namespace :my do
    resources :projects do
      resources :images
    end
  end

  root to: "home#index"
end
