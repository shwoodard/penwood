class ApplicationController < ActionController::Base
  before_filter :clear_static_assets if Rails.env.development?
  
  helper :all 
  helper_method :current_user_session, :current_user

  protect_from_forgery 
  filter_parameter_logging :password, :password_confirmation
  

  private
    def current_user_session
      return @current_user_session if defined?(@current_user_session)
      @current_user_session = UserSession.find
    end

    def current_user
      return @current_user if defined?(@current_user)
      @current_user = current_user_session && current_user_session.user
    end
  
  def clear_static_assets 
    Static::Asset.descriptor.clear
  end
  
end
