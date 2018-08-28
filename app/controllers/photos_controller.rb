class PhotosController < ApplicationController
  
  def new
    @photo = Photo.new
  end

  def create 
    @photo = current_user.photos.build(photo_params)
    if @photo.save
      redirect_to root_path
    else
      redirect_to new_photo_path
    end
  end

  def index
    @photos = Photo.order("created_at")
  end

  def show 
    @photo = Photo.find(params[:id])
  end

  private

  def photo_params
    params.require(:photo).permit(:name, :image)
  end
end
