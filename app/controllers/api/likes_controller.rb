module Api
  class LikesController < ApiController
    def create
      outcome = Likes::Create.run(params)
      if outcome.valid?
        render json: { message: 'Like created!', like: outcome.result }, status: :created
      else
        render json: { message: 'Like don`t created!', errors: outcome.errors.details }, status: :bad_request
      end
    end

    def destroy
      outcome = Likes::Destroy.run(params)
      if outcome.valid?
        head 204
      else
        render json: { message: 'Like don`t deleted!', errors: outcome.errors.details }, status: :bad_request
      end
    end
  end
end
