class LikesController < ApplicationController

  def create
    @photo = Photo.find(params[:photo_id])
    @like = Like.new(photo: @photo, user: current_user)
    respond_to do |format|
      if @like.save
        format.html { redirect_to @photo }
        format.json { render json: { photo_id: @photo.id, likes_count: @photo.likes_count, like_id: @like.id } }
      else
      end
    end
  end

  def destroy
    photo = Photo.find(params[:photo_id])
    like = Like.find_by(photo: photo, user: current_user)
    
    respond_to do |format|
      if like.destroy
        format.json { render json: { photo_id: photo.id, likes_count: photo.likes_count-1 } }
        format.html { redirect_to photo }
      end
    end
  end
end
