class SessionsController < Devise::OmniauthCallbacksController

  

  def vkontakte
    create
  end

  def github
    create
  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_path
  end

  private

  def create
    @user = User.from_omniauth(request.env['omniauth.auth'])
    @user.update_access_token
    session[:user_id] = @user.id if @user.persisted?
    redirect_to root_path
  end
end
