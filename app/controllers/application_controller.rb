class ApplicationController < ActionController::Base
  before_filter :clear_static_assets if Rails.env.development?

  helper :all 
  helper_method :current_user_session, :current_user, :member?, :logged_in?, :guest?

  protect_from_forgery 
  filter_parameter_logging :password, :password_confirmation


  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  
  def member?
    !!cookies[:member]
  end
  
  def logged_in?
    !!current_user
  end
  
  def guest?
    !logged_in?
  end

  def current_user_admin?
    current_user && current_user.admin?
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = 'You must be logged in to do this.'
      redirect_to root_path
    end
  end
  
  def require_no_user
    if current_user
      store_location
      flash[:notice] = 'You must be logged out to do this.'
      redirect_to root_path
    end
  end
  
  def store_location
    session[:return_to] = request.request_uri
  end
  
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
  
  def set_member_cookie
    cookies[:member] = true
  end
  
  def clear_static_assets 
    Static::Asset.descriptor.clear
  end
  
end
