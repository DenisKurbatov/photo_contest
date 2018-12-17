module Users
  class PhotosController < ApplicationController
    def index
      @photos = ListPhotos.run!(user_id: current_user.id)
    end
  end
end
