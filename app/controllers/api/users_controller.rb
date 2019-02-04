module Api
  class UsersController < ApiController
    def index
      users = User.select(:id, :name, :provider, :email, :url, :access_token)
      users = users.page(params[:page]).per(params[:per])
      render json: { users: users, page: paginate_params(users) }, status: 200
    end
  end
end
