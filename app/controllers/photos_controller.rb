class PhotosController < ApplicationController
  before_action :take_photo, only: [:show, :destroy]
  
  def new
    @photo = Photo.new
  end

  def create 
    @photo = current_user.photos.new(photo_params) 
    if @photo.save
      redirect_to root_path
    else
      redirect_to new_photo_path
    end
  end

  def index
    
    @photos = Photo.approved.page(params[:page])
    @photos = @photos.reorder("#{sort_column} #{sort_direction}")
    if params[:search].present?
      @photos = @photos.where("name ILIKE '%#{params[:search]}%'")
    end
    
    
  end
  
  def show 
  end

  def destroy
    @photo.destroy
    redirect_to user_photos_path(current_user)
  end

  private

  def sort_column
    Photo.column_names.include?(params[:sort]) ? params[:sort] : "likes_count"
  end
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def take_photo
    @photo = Photo.find(params[:id])
  end
end
