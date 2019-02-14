module Api
  class LikesController < ApiController
    def create
      outcome = Likes::Create.run(params)
      if outcome.valid?
        render json: { message: 'Like created!', like: outcome.result }, status: :created
      else
        render json: outcome.errors.details, status: :bad_requst
      end
    end

    def destroy
      outcome = Likes::Destroy.run(params)
      if outcome.valid?
        head 204
      else
        render json: outcome.errors.details, status: :bad_requst
      end
    end
  end
end
