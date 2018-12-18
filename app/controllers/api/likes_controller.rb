module Api
  class LikesController < ApiController
    before_action :define_photo_and_user

    def create
      outcome = CreateLike.run(photo_id: photo.id, user_id: user.id)
      if outcome.valid?
        render json: { message: 'Like created!', result: outcome.result }, status: 201
      else
        render json: { message: 'Like don`t created!', result: outcome.errors.details }, status: 400
      end
    end

    def destroy
      outcome = DestroyLike.run(like_id: params[:id], user_id: user.id)
      if outcome.valid?
        render json: { message: 'Like deleted', result: outcome.result }, status: 201
      else
        render json: { message: 'Like don`t deleted!', result: outcome.errors.details }, status: 400
      end
    end

    private

    def define_photo_and_user
      @photo = Photo.find(params[:photo_id])
      @user = User.find_by(access_token: request.headers[:token])
    end

    def photo
      @photo ||= Photo.find(params[:photo_id])
    end

    def user
      @user ||= User.(access_token: request.headers[:token])
    end
  end
end
