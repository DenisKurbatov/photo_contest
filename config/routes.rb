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


  get "/user/:user_id/photos/:photo_id/comment/:comment_parent_id/comments/new", to: "comments#new", as: "new_user_photo_comment_comments"
  post "/user/:user_id/photos/:photo_id/comment/:comment_parent_id/comments", to: "comments#create", as: "user_photo_comment_comments"
  delete "photos/:photo_id", to: "photos#destroy"
  
end
