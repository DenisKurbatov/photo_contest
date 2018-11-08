module Users
  class PhotosController < ApplicationController
    def index
      @photos = Photo.by_user(params[:user_id]).page params[:page]
    end
  end
end
