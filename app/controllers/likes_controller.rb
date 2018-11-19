class LikesController < ApplicationController
  def create
    @photo = Photo.find(params[:photo_id])
    outcome = CreateLike.run(user_id: current_user.id, photo_id: @photo.id)
    respond_to do |format|
      format.html { redirect_to @photo }
      format.json do
        render json: { photo_id: @photo.id, likes_count: @photo.likes_count + 1, like_id: outcome.result.id }
      end
    end
  end

  def destroy
    @photo = Photo.find(params[:photo_id])
    @like = Like.find_by(user_id: current_user.id, photo_id: @photo.id)
    DestroyLike.run(like: @like)
    respond_to do |format|
      format.html { redirect_to @photo }
      format.json do
        render json: { photo_id: @photo.id, likes_count: @photo.likes_count - 1 }
      end
    end
  end
end
