module Api
  class PhotosController < ApiController
    
    layout false

    def index
      @photos = Photo.approved.page(params[:page])
      render json: @photos
    end

    def show
      @photo = Photo.find(params[:id])
      render json: @photo
    end

    def show_photos
      @photos = Photo.by_user(params[:id])
      render json: @photos
    end

  end
end
