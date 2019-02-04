module Api
  class CommentsController < ApiController
    def create
      outcome = Comments::Create.run(params)
      if outcome.valid?
        render json: { message: 'Comment was created!', result: outcome.result }, status: :created
      else
        render json: { message: 'Comment don`t created!', errors: outcome.errors.details }, status: :bad_requst
      end
    end
  end
end
