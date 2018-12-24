class PhotosController < ApplicationController

  def new
    @photo = Photos::Create.new
  end

  def create
    outcome = Photos::Create.run(photo_params)
    if outcome.valid?
      redirect_to user_photos_path(current_user)
    else
      @photo = outcome
      render(:new)
    end
  end

  def index
    outcome = Photos::List.run(sorting: "#{sort_column} #{sort_direction}", search: params[:search])
    if outcome.valid?
      @photos = outcome.result.page(params[:page])
    else
      @photos = []
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    outcome = Photos::Find.run(photo_id: params[:id])
    if outcome.valid?
      @photo = outcome.result
    else
      redirect_to root_path
    end
  end

  def destroy
    Photos::Destroy.run!(photo_id: params[:id], user_id: current_user.id)
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
    params.require(:photo).permit(:name, :image).merge(user_id: current_user.id)
  end
end
