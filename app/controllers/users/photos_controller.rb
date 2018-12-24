module Users
  class PhotosController < ApplicationController
    def index
      @photos = Photos::List.run!(user_id: current_user.id)
    end
  end
end
