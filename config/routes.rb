Rails.application.routes.draw do
  get 'attachment/upload'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'home#index'

  get 'home/index'

  post 'attachments/upload'

  post 'sign_in' => 'auth#login'
  post 'sign_up' => 'auth#sign_up'

  resources :projects do
    resources :tasks do
      resources :comments, only: [:index, :create, :destroy]
      resources :attachments, only: :index
      collection do
        post :reorder_position
      end
    end
  end
end
