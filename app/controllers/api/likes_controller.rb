module Api
  class LikesController < ApiController
    def create
      outcome = Likes::Create.run(params)
      if outcome.valid?
        render json: { message: 'Like created!', like: outcome.result }, status: 201
      else
        render json: { message: 'Like don`t created!', errors: outcome.errors.details }, status: 400
      end
    end

    def destroy
      outcome = Likes::Destroy.run(params)
      if outcome.valid?
        render json: { message: 'Like deleted', like: outcome.result }, status: 201
      else
        render json: { message: 'Like don`t deleted!', errors: outcome.errors.details }, status: 400
      end
    end
  end
end
