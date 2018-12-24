module Api
  class CommentsController < ApiController
    def create
      outcome = Comments::Create.run(comment_params)
      if outcome.valid?
        render json: { message: 'Comment was created!', result: outcome.result }, status: 201
      else
        render json: { message: 'Comment don`t created!', errors: outcome.errors.details }, status: 422
      end
    end

    private

    def comment_params
      { photo_id: params[:id], comment_parent_id: params[:id], user_id: user_id, body: request[:content] }
    end

    def user_id
      User.find_by(access_token: request.headers[:token]).id if User.where(access_token: request.headers[:token]).exists?
    end
  end
end
