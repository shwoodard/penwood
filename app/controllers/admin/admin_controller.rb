class Admin::AdminController < ApplicationController
  layout 'admin'
  before_filter :require_user
  before_filter :require_admin_user
  
  def current_user_super_user?
    current_user_admin? && current_user.super_user?
  end
  
  def require_admin_user
    unless current_user_admin?
      flash[:notice] = 'You do not have access.'
      current_user_session.destroy
      redirect_to root_path
    end
  end
  
  def require_super_user
    unless current_user_super_user?
      flash[:notice] = 'You do not have access.'
      redirect_to admin_root_path
    end
  end
end
