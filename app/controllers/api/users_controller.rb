class Api::UsersController < ApplicationController

  layout false

  def index
    @users = User.all
    render json: @users
  end

end
