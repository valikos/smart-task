Rails.application.routes.draw do
  root 'home#index'

  get 'home/index'

  resources :projects do
    resources :tasks do
      collection do
        post :reorder_position
      end
    end
  end
end
