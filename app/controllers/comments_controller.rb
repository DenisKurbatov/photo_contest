class CommentsController < ApplicationController
  def new
    @comment_parent = Comment.find(params[:comment_parent_id]) if params[:comment_parent_id] != "0"
    @comment = Comment.new
  end

  def create
    photo = Photo.find(params[:photo_id])
    @comment = Comment.new(photo: photo, user: current_user,
                            body: params[:comment]["body"],
                            comment_parent_id: params[:comment_parent_id])
    if @comment.save
      redirect_to photo_path(photo)
    else
      redirect_to new_user_photo_comment_comments_path(comment_parent_id: "0", photo_id: photo, user_id: current_user)
    end
  end
end
