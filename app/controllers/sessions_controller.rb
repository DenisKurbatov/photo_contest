class SessionsController < Devise::OmniauthCallbacksController
  
  def vkontakte
    @user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = @user.id if @user.persisted?
    redirect_to root_path
  end

  def github
    @user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = @user.id if @user.persisted?
    redirect_to root_path
  end

  def create
    byebug
    @user = User.from_omniauth(request.env['omniauth.auth'])
    session[:user_id] = @user.id if @user.persisted?
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_path
  end
end
