Rails.application.routes.draw do
  get 'attachment/upload'

  root 'home#index'

  get 'home/index'

  post 'attachments/upload'

  post 'sign_in' => 'auth#login'
  post 'sign_up' => 'auth#sign_up'
  post 'auth/facebook' => 'auth#facebook'

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
