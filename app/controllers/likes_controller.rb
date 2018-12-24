class LikesController < ApplicationController
  def create
    outcome = Likes::Create.run(user_id: current_user.id, photo_id: params[:photo_id])
    respond_to do |format|
      format.html { redirect_to photo_path(outcome.result.photo_id) }
      format.json do
        render json: { photo_id: outcome.result.photo_id,
                       likes_count: outcome.count,
                       like_id: outcome.result.id }
      end
    end
  end

  def destroy
    outcome = Likes::Destroy.run(user_id: current_user.id, photo_id: params[:photo_id])
    respond_to do |format|
      format.html { redirect_to photo_path(outcome.result.photo_id) }
      format.json do
        render json: { photo_id: outcome.result.photo_id, likes_count: outcome.count }
      end
    end
  end
end
