Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  root 'home#index'

  get 'home/index'

  post 'sign_in' => 'auth#login'
  post 'sign_up' => 'auth#sign_up'

  resources :projects do
    resources :tasks do
      collection do
        post :reorder_position
      end
    end
  end
end
