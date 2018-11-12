module Api
  class PhotosController < ApiController

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
