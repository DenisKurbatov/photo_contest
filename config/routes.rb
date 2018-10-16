Rails.application.routes.draw do
  
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { omniauth_callbacks: 'sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"
  devise_scope :user do
    delete 'logout', to: 'sessions#destroy'
  end

  
  resources :photos do
    resources :likes, only: [:create, :destroy]
  end
  

  resources :user, only: :none do
    resources :photos, only: :index, module: :users
  end

  get "users/:id", to: "users#show", as: "users"
  get "photos/:photo_id/:comment_parent_type/:comment_parent_id/comments/new", to: "comments#new", as: "new_user_photo_comment_comments"
  post "photos/:photo_id/:comment_parent_type/:comment_parent_id/comments", to: "comments#create", as: "user_photo_comment_comments"
  delete "photos/:photo_id", to: "photos#destroy"
  
end
