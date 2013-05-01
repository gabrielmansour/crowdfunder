Crowdfunder::Application.routes.draw do
  resources :projects do
    resources :pledges
  end

  resources :users

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  root to: "home#index"
end
