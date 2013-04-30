Crowdfunder::Application.routes.draw do
  resources :projects
  resources :users

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  get 'logout' => 'sessions#destroy'

  root to: "home#index"
end
