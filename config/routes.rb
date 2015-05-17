Rails.application.routes.draw do
  root 'home#index'

  get 'home/index'

  resources :projects do
    resources :tasks
  end
end
