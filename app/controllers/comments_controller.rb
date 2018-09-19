class CommentsController < ApplicationController
  def new
    
    @comment = Comment.new
  end

  def create
    photo = Photo.find(params[:photo_id])
    if params[:comment_parent_type] == "photo"
      @comment = photo.comments.new(user_id: current_user.id, 
                                    body: params[:comment][:body])
    else
      comment_parent = Comment.find(params[:comment_parent_id])
      @comment = comment_parent.comments.new(user_id: current_user.id,
                                             body: params[:comment][:body])
     
    end
    
    if @comment.save
      redirect_to photo_path(photo)
    else
      redirect_to new_user_photo_comment_comments_path()
    end
  end
end

private

