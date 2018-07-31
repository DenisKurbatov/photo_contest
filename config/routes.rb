Rails.application.routes.draw do
  
  devise_for :users, controllers: { omniauth_callbacks: 'sessions' }
  root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  devise_scope :user do
    delete 'logout', to: 'sessions#destroy'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
