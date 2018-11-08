Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'sessions' }
  devise_for :admin_users, ActiveAdmin::Devise.config

  namespace :api, defaults: {format: :json} do
    get 'photos', to: 'photos#index'
    get 'photos/:id', to: 'photos#show'
    get 'users', to: 'users#index'
    get 'user/:id/photos', to: 'photos#show_photos'
  end


  root 'photos#index'
  devise_scope :user do
    delete 'logout', to: 'sessions#destroy'
  end
  resources :photos do
    resources :likes, only: %i[create destroy]
  end
  resources :user, only: :none do
    resources :photos, only: :index, module: :users
  end

  
  get 'users/:id', to: 'user#show', as: 'users'
 
  get 'photos/:photo_id/:comment_parent_type/:comment_parent_id/comments/new', to: 'comments#new',
                                                                               as: 'new_user_photo_comment_comments'
  post 'photos/:photo_id/:comment_parent_type/:comment_parent_id/comments', to: 'comments#create',
                                                                            as: 'user_photo_comment_comments'
  delete 'photos/:photo_id', to: 'photos#destroy'
  get '/admin/photos/:user_id', to: 'admin/photos#index_user', as: 'admin_photos_user' 
  ActiveAdmin.routes(self)
end
