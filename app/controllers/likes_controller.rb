class LikesController < ApplicationController

  def create
    photo = Photo.find(params[:photo_id])
    @like = Like.new(photo: photo, user: current_user)
    respond_to do |format|
      if @like.save
        format.html { redirect_to photo }
        format.js
      else
        
      end
    end
  end

  def destroy
    photo = Photo.find(params[:photo_id])
    like = Like.find_by(photo: photo, user: current_user)
    like.destroy
    redirect_to photo
  end
end
