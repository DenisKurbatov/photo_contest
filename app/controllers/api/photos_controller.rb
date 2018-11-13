module Api
  class PhotosController < ApiController

    def create
      user = User.find_by(access_token: request.headers[:token])
      photo = user.photos.new(name: request[:photo_name], image: request[:image])
      if photo.save
        result = "Photo uploaded"
      else
        result = "Photo don`t uploaded"
      end
      render json: { message: result }
    end

    def destroy
      user = User.find_by(access_token: request.headers[:token])
      photo = Photo.find(params[:id])
      if user.id == photo.user_id
        photo.destroy
        result = "Photo was removed"
        
      else
        result = "You can`t remove this photo"
      end
      render json: { message: result }
    end
    

    def index
      @photos = Photo.approved.page(params[:page])
      render json: @photos, status: 200
    end

    def show
      @photo = Photo.find(params[:id])
      render json: @photo, status: 200
    end

    def show_photos
      @user = User.find_by(access_token: request.headers[:token])
      if @user.id == params[:id].to_i
        @photos = Photo.by_user(params[:id])
        render json: @photos, status: 200
      else
        render json: {message: "Incorrect access token"}
      end

    end
  end
end
