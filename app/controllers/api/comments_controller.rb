module Api
  class CommentsController < ApiController
    def create
      outcome = Comments::Create.run(params)
      if outcome.valid?
        render json: { message: 'Comment was created!', result: outcome.result }, status: 201
      else
        render json: { message: 'Comment don`t created!', errors: outcome.errors.details }, status: 422
      end
    end
  end
end
