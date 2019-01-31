Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'sessions' }
  devise_for :admin_users, ActiveAdmin::Devise.config
  devise_scope :user do
    delete 'logout', to: 'sessions#destroy'
  end

  root 'photos#index'

  namespace :api, defaults: { format: :json } do
    resources :photos, only: %i[index show create destroy] do
      resources :comments, only: :create
      #resources :likes, only: %i[create destroy]
      post 'likes', to: 'likes#create'
      delete 'likes', to: 'likes#destroy'
    end
    resources :users, only: :index do
      resources :photos, only: :index
    end
  end

  resources :photos, only: %i[new create index show destroy] do
    resources :likes, only: %i[create destroy]
  end
  resources :user, only: :none do
    resources :photos, only: :index, module: :users
  end
  resources :users, only: %i[show update]

  get 'photos/:photo_id/:comment_parent_type/:comment_parent_id/comments/new', to: 'comments#new',
                                                                               as: 'new_user_photo_comment_comments'
  post 'photos/:photo_id/:comment_parent_type/:comment_parent_id/comments', to: 'comments#create',
                                                                            as: 'user_photo_comment_comments'

  get '/admin/photos/:id', to: 'admin/photos#show', as: 'admin_photos_user'
  ActiveAdmin.routes(self)
end
