Crowdfunder::Application.routes.draw do
  resources :projects
  resources :users

  root to: "home#index"
end
