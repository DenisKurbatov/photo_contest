class LikesController < ApplicationController
  before_action :merge_user_token_to_params

  def create
    outcome = Likes::Create.run(params)
    respond_to do |format|
      format.html { redirect_to photo_path(outcome.result[:photo_id]) }
      format.json { render json: outcome.result }
    end
  end

  def destroy
    outcome = Likes::Destroy.run(params)
    respond_to do |format|
      format.html { redirect_to photo_path(outcome.result[:photo_id]) }
      format.json do
        render json: { photo_id: outcome.result.photo_id, likes_count: outcome.count }
      end
    end
  end

  private

  def merge_user_token_to_params
    params.merge!(access_token: current_user.access_token)
  end
end
