class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    outcome = Comments::Create.run(params.merge(comment_params))
    if outcome.valid?
      redirect_to photo_path(outcome.photo_id)
    else
      redirect_to new_user_photo_comment_comments_path
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id)
  end
end
