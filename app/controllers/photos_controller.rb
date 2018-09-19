class PhotosController < ApplicationController
  before_action :take_photo, only: [:show, :destroy]
  def new
    @photo = Photo.new
  end

  def create 
    @photo = current_user.photos.new(photo_params) 
    if @photo.save
      flash[:success] = "Фотография добавлена"
      redirect_to root_path
    else
      flash[:danger] = "Ошибка загрузки"
      redirect_to new_photo_path
    end
  end

  def index
    @photos = Photo.order(created_at: :asc).page params[:page]
  end
  
  def index_my_photos
    @photos = Photo.from_user(current_user).page params[:page]
  end

  def show 
    
  end
  def destroy
    
    @photo.destroy
    flash[:success] = "Фотография успешно удалена"
    redirect_to user_photo_path(current_user)
  end

  private

  def photo_params
    params.require(:photo).permit(:name, :image)
  end

  def take_photo
    @photo = Photo.find(params[:id])
  end
end
