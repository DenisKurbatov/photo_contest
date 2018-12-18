module Api
  class CommentsController < ApiController
    before_action :define_photo_and_user

    def create
      outcome = CreateComment.run(comment_parent_id: @photo.id, body: request[:content], user_id: @user.id)
      if outcome.valid?
        render json: { message: 'Comment was created!', result: outcome.result }, status: 201
      else
        render json: { message: 'Comment don`t created!' }, status: 422
      end
    end

    private

    def define_photo_and_user
      @photo = Photo.find(params[:id])
      @user = User.find_by(access_token: request.headers[:token])
    end
  end
end
