class LikesController < ApplicationController
  def create
    outcome = CreateLike.run(user_id: current_user.id, photo_id: params[:photo_id])
    respond_to do |format|
      format.html { redirect_to photo_path(params[:photo_id]) }
      format.json do
        render json: { photo_id: params[:photo_id], likes_count: Photo.find(params[:photo_id]).likes_count, like_id: outcome.result.id }
      end
    end
  end

  def destroy
    DestroyLike.run(like_id: params[:id], user_id: current_user.id)
    respond_to do |format|
      format.html { redirect_to photo_path(params[:photo_id]) }
      format.json do
        render json: { photo_id: params[:photo_id], likes_count: Photo.find(params[:photo_id]).likes_count }
      end
    end
  end
end
