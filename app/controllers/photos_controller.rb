class PhotosController < ApplicationController
  def new
    @photo = Photo.new
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
    outcome = Photos::List.run(sorting: "#{sort_column} #{sort_direction}", search: params[:search], page: params[:page])
    if outcome.valid?
      @photos = outcome.result
    else
      @photos = []
    end
    respond_to do |format|
      format.html
      format.js
    end
  end

  def show
    outcome = Photos::Find.run(params)
    if outcome.valid?
      @photo = outcome.result
    else
      redirect_to root_path
    end
  end

  def destroy
    outcome = Photos::Destroy.run(params.merge(user_id: current_user.id))
    redirect_to user_photos_path(outcome.result[:user_id])
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
