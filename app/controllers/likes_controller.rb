class LikesController < ApplicationController
  def create
    photo = Photo.find(params[:photo_id])
    @like = Like.create(photo: photo, user: current_user)
  end

  def destroy
    photo = Photo.find(params[:photo_id])
    like = Like.find_by(photo: photo, user: current_user)
    like.destroy
  end
end
