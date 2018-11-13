module Api
  class CommentsController < ApiController
    def create
      @user = User.find_by(access_token: request.headers[:token])
      @photo = Photo.find(params[:id])
      @comment = @photo.comments.new(user_id: @user.id, body: request[:content])
      if @comment.save
        render json: { message: 'Comment was created!' }, status: 201
      else
        render json: { message: 'Comment don`t created!' }, status: 422
      end
    end
  end
end
