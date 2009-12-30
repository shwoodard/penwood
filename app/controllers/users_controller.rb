class UsersController < ApplicationController
  before_filter :require_user, :only => [:show, :edit, :update]

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
  
  def activate
    user = User.find_using_perishable_token(params[:activation_code], 1.week)
    if user
      user.activate!
      flash[:notice] = 'You have successfully activated your account.'
      UserSession.create(user, true)
      set_member_cookie
      redirect_to root_path
    else
      
    end
  end
end
