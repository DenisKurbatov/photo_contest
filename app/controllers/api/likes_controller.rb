module Api
  class LikesController < ApiController
    before_action :define_photo_and_user

    def create
      outcome = Likes::Create.run(user_id: get_user_id_by_access_token, photo_id: params[:photo_id].to_i)
      if outcome.valid?
        render json: { message: 'Like created!', result: outcome.result }, status: 201
      else
        render json: { message: 'Like don`t created!', result: outcome.errors.details }, status: 400
      end
    end

    def destroy
      outcome = Likes::Destroy.run(user_id: get_user_id_by_access_token, photo_id: params[:photo_id].to_i)
      if outcome.valid?
        render json: { message: 'Like deleted', result: outcome.result }, status: 201
      else
        render json: { message: 'Like don`t deleted!', result: outcome.errors.details }, status: 400
      end
    end

    private

    def define_photo_and_user
      @photo = Photo.find_by(id: params[:photo_id])
      @user = User.find_by(access_token: request.headers[:token])
    end

    def photo
      @photo ||= Photo.find_by(params[:photo_id])
    end

    def user
      @user ||= User.find_by(access_token: request.headers[:token])
    end
    def get_user_id_by_access_token
      User.select(:id).find_by(access_token: request.headers[:token]).id
    end
  end
end
