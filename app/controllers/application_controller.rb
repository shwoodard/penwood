class ApplicationController < ActionController::Base
  before_filter :set_page
  before_filter :require_valid_user

  helper_method :current_user_session, :current_user, :member?, :logged_in?, :guest?, :current_user_admin?

  protect_from_forgery 

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
      flash[:notice] = 'You must be logged in to view that page.'
      redirect_to contact_path
    end
  end
  
  def require_no_user
    if current_user
      store_location
      flash[:notice] = 'You must be logged out to view that page.'
      redirect_to root_path
    end
  end
  
  def require_valid_user
    if current_user && current_user.banned?
      flash[:notice] = 'You are banned!'
      current_user_session.destroy
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
    
  def set_page
    @page = Page.find_by_path(request.path)
  end
  
end
