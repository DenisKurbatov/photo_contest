module Api
  class UsersController < ApiController
    def index
      @users = User.select(:id, :name, :provider, :email, :url, :access_token).all.includes(photos: :user)
      render json: @users, status: 200, root: :users
    end
  end
end
