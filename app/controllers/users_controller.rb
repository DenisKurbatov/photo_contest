class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update_access_token
    respond_to do |format|
      format.js
    end
  end

end
