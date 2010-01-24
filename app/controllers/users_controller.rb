class UsersController < ApplicationController
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def create
    @user = User.new(params[:user])
    if @user.save_without_session_maintenance
      @user.reset_perishable_token!
      @user.activation_url = activate_user_url(@user.perishable_token)
      ActivationNotifier.deliver_activation_email(@user)
      ContactNotifier.deliver_new_user_email(@user)
      flash[:notice] = "Account registered! You will receive an email shortly.  Please follow the link in the email to activate your account."
      redirect_back_or_default contact_path
    else
      @user_session = UserSession.new
      render :template => 'contact/index'
    end
  end

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
  
  def change_email
    @user = current_user
  end
  
  def change_password
    @user = current_user
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
      flash[:notice] = 'Your activation code is no longer valid.'
      redirect_to :action => 'resend_activation_email'
    end
  end
  
  def resend_activation_email
    @user = User.new
  end
  
  def send_activation_email
    @user = User.find_by_email(params[:user][:email])
    if @user
      unless @user.active?
        @user.reset_perishable_token!
        @user.activation_url = activate_user_url(@user.perishable_token)
        ActivationNotifier.deliver_activation_email(@user)
        flash[:notice] = 'Your activation email has been successfully resent.'
        redirect_to root_path
      else
        flash[:notice] = 'This user is already active.'
        redirect_to root_path
      end
    else
      flash[:notice] = 'This is not a known email address.'
      render :action=> 'resend_activation_email'
    end
  end
end
