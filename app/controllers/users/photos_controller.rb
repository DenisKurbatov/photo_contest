module Users
  class PhotosController < ApplicationController
    def index
      if current_user.id == params[:user_id].to_i
        @photos = Photo.by_user(params[:user_id]).page params[:page]
      else
        redirect_to user_photos_path(current_user)
      end
    end
  end
end
