class UsersController < ApplicationController
  before_action :auth_user

  def show
    @user = current_user
  end

  def update
    @user = User.update(params[:id], access_token: User.update_access_token)
    respond_to do |format|
      format.js
    end
  end

  private

  def auth_user
    redirect_to root_path unless current_user
  end
end
