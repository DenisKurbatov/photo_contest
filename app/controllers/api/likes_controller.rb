module Api
  class LikesController < ApiController
    def create
      outcome = Likes::Create.run(user_id: user_id, photo_id: params[:photo_id])
      if outcome.valid?
        render json: { message: 'Like created!', like: outcome.result }, status: 201
      else
        render json: { message: 'Like don`t created!', errors: outcome.errors.details }, status: 400
      end
    end

    def destroy
      outcome = Likes::Destroy.run(user_id: user_id, photo_id: params[:photo_id])
      if outcome.valid?
        render json: { message: 'Like deleted', like: outcome.result }, status: 201
      else
        render json: { message: 'Like don`t deleted!', errors: outcome.errors.details }, status: 400
      end
    end

    private

    def user_id
      User.find_by(access_token: request.headers[:token]).id if User.where(access_token: request.headers[:token]).exists?
    end
  end
end
