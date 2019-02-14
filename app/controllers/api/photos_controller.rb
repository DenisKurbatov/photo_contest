module Api
  class PhotosController < ApiController
    skip_before_action :merge_token_to_params, only: :index

    def create
      outcome = Photos::Create.run(params)
      if outcome.valid?
        render json: { message: 'Photo uploaded', photo: outcome.result }, status: :created
      else
        render json: outcome.errors.details, status: :bad_requst
      end
    end

    def destroy
      outcome = Photos::Destroy.run(params)
      if outcome.valid?
        render json: { message: 'Photo was removed', photo: outcome.result }, status: :ok
      else
        render json: outcome.errors.details, status: :bad_requst
      end
    end

    def index
      outcome = Photos::List.run(params)
      if outcome.valid?
        photos = outcome.result.select(:id, :name, :image, :user_id, :likes_count, :comments_count, :all_comments_count).includes(:comments)
        render json: { photos_list: photos, page: paginate_params(photos) }, status: :ok
      else
        render json: outcome.errors.details, status: :bad_requst
      end
    end

    def show
      outcome = Photos::Find.run(params)
      if outcome.valid?
        render json: outcome.result, status: :ok
      else
        render json: outcome.errors.details, status: :bad_requst
      end
    end
  end
end
