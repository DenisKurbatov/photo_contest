Rails.application.routes.draw do
  
  devise_for :users, controllers: { omniauth_callbacks: 'sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"
  devise_scope :user do
    delete 'logout', to: 'sessions#destroy'
  end
  resources :photos do
    resources :likes, only: [:create, :destroy]
  end
  get "/:id/photos", to: "photos#index_my_photos", as: "user_photo"
  
end
