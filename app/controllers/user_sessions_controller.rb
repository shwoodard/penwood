class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => :create
  before_filter :require_user, :only => :destroy

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "Sign in successful!"
      set_member_cookie
      redirect_back_or_default root_path
    else
      @user = User.new unless member?
      render :template => 'contact/index.html.erb'
    end
  end

  def destroy
    current_user_session.destroy
    flash[:notice] = "Sign out successful!"
    redirect_back_or_default root_path
  end
end
