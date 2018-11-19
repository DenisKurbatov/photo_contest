module Api
  class PhotosController < ApiController
    def create
      user = User.find_by(access_token: request.headers[:token])
      photo = user.photos.new(name: request[:photo_name], image: request[:image])
      if photo.save
        render json: { message: 'Photo uploaded', photo_id: photo.id }, status: 201
      else
        render json: { message: 'Photo don`t uploaded' }, status: 422
      end
    end

    def destroy
      user = User.find_by(access_token: request.headers[:token])
      photo = Photo.find(params[:id])
      if user.id == photo.user_id
        photo.destroy
        render json: { message: 'Photo was removed' }, status: 200
      else
        render json: { message: 'Photo not was removed' }, status: 200
      end
    end

    def index
      @photos = Photo.select(:id, :name, :image, :user_id, :likes_count, :comments_count, :all_comments_count).approved.includes(:comments)
      @photos = @photos.page(params[:page].blank? ? 1 : params[:page][:number])
      render json: @photos, adapter: :json_api
    end

    def show
      photo = Photo.find(params[:id])
      render json: photo, status: 200
    end

    def show_photos
      user = User.find_by(access_token: request.headers[:token])
      if user.id == params[:id].to_i
        @photos = Photo.by_user(params[:id])
        render json: @photos, status: 200
      else
        render json: { message: 'Incorrect access token' }, status: 403
      end
    end
  end
end
