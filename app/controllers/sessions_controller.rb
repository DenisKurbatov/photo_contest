class SessionsController < Devise::OmniauthCallbacksController
  def vkontakte
    @user = User.from_omniauth(request.env["omniauth.auth"])
  
    if @user.persisted?
      session[:user_id] = @user.id
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_path
  end
end

