class ApplicationController < ActionController::Base

  def admin_locale
    I18n.locale = :ru
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
