module Api
  class PhotosController < ApiController
    def create
      outcome = Photos::Create.run(name: request[:photo_name], image: request[:image], user_id: user_id)
      if outcome.valid?
        render json: { message: 'Photo uploaded', photo: outcome.result }, status: 201
      else
        render json: { message: 'Photo don`t uploaded', errors: outcome.errors.details }, status: 422
      end
    end

    def destroy
      outcome = Photos::Destroy.run(photo_id: params[:id], user_id: user_id)
      if outcome.valid?
        render json: { message: 'Photo was removed', photo: outcome.result }, status: 200
      else
        render json: { message: 'Photo not was removed', errors: outcome.errors.details }, status: 422
      end
    end

    def index
      outcome = Photos::List.run
      if outcome.valid?
        @photos = outcome.result.select(:id, :name, :image, :user_id, :likes_count, :comments_count, :all_comments_count).includes(:comments)
        @photos = @photos.page(params[:page].blank? ? 1 : params[:page][:number])
        render json: @photos
      else
        render json: outcome.errors.details
      end
    end

    def show
      outcome = Photos::Find.run(photo_id: params[:id])
      if outcome.valid?
        photo = outcome.result
        render json: photo, status: 200
      else
        render json: outcome.errors.details, status: 422
      end
    end

    def show_photos
      outcome = Photos::List.run(user_id: user_id)
      if outcome.valid?
        photos = outcome.result
        render json: photos, status: 200
      else
        render json: outcome.errors.details, status: 422
      end
    end

    private

    def user_id
      User.find_by(access_token: request.headers[:token]).id if User.where(access_token: request.headers[:token]).exists?
    end
  end
end
