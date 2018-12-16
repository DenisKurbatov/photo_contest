class PhotosController < ApplicationController
  before_action :take_photo, only: %i[show destroy]

  def new
    @photo = CreatePhoto.new
  end

  def create
    outcome = CreatePhoto.run(photo_params)
    if outcome.valid?
      redirect_to user_photos_path(current_user)
    else
      @photo = outcome
      render(:new)
    end
  end

  def index
    @photos = ListPhotos.run!(sorting: "#{sort_column} #{sort_direction}", search: params[:search]).page(params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show; end

  def destroy
    DestroyPhoto.run!(photo: @photo)
    redirect_to user_photos_path(current_user)
  end

  private

  def sort_column
    Photo.column_names.include?(params[:sort]) ? params[:sort] : 'likes_count'
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

  def photo_params
    params.require(:photo).permit(:name, :image).merge(user: current_user)
  end

  def take_photo
    @photo = Photo.find(params[:id])
  end
end
