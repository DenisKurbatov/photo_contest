class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    outcome = CreateComment.run(comment_params)
    if outcome.valid?
      update_all_comment_count
      redirect_to photo_path(params[:photo_id])
    else
      redirect_to new_user_photo_comment_comments_path
    end
  end

  private

  def update_all_comment_count
    new_count = Photo.find(params[:photo_id]).all_comments_count
    Photo.update(params[:photo_id], all_comments_count: new_count)
  end

  def comment_params
    { comment_parent_type: params[:comment_parent_type], comment_parent_id: params[:comment_parent_id],
      user_id: current_user.id, body: params[:comment][:body] }
  end
end
