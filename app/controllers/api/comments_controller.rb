module Api
  class CommentsController < ApiController
    def create
      @user = User.find_by(access_token: request.headers[:token])
      @photo = Photo.find(params[:id])
      body = request.headers[:body]
      @comment = @photo.comments.new(user_id: @user.id, body: body)
      if @comment.save
        result = "Comment created!"
      else
        result = "Comment not created!"
      end
      render json: {message: result}
    end
  end
end