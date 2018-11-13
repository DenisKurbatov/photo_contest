class UsersController < ApplicationController
  before_action :auth_user

  def show
    if current_user.id == params[:id].to_i
      @user = User.find(params[:id])
    else
      redirect_to users_path(current_user.id)
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(access_token: update_access_token)
    respond_to do |format|
      format.js
    end
  end

  private

  def auth_user
    redirect_to root_path unless current_user
  end

  def update_access_token
    access_token = SecureRandom.urlsafe_base64(32)
    generate_access_token if User.exists?(access_token: access_token)
    access_token
  end
end
