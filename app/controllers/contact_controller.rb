class ContactController < ApplicationController
  before_filter :require_no_user, :only => :create
  
  def index
    redirect_to conversations_path if current_user
    @user_session = UserSession.new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.register
      if @user.save_without_session_maintenance
        @user.reset_perishable_token!
        @user.activation_url = activate_user_url(@user.perishable_token)
        ActivationNotifier.deliver_activation_email(@user)
        ContactNotifier.deliver_new_user_email(@user)
        flash[:notice] = 'The information you submitted has been sent to Penwood Partners and your registration has been processed. You will receive an email shortly.  Please follow the link in the email to activate your account.'
        redirect_to root_path
      else
        flash.now[:notice] = "You have been banned!" if !@user.new_record? && @user.banned?
        @user_session = UserSession.new
        render :action => 'index'
      end
    else
      unless @user.email.blank? || @user.name.blank?
        ContactNotifier.deliver_new_contact_email(@user)
        flash[:notice] = 'The information you submitted has been sent to Penwood Partners.'
        redirect_to root_path
      else
        flash[:notice] = "Both email and name are required."
        @user_session = UserSession.new
        render :action => 'index'
      end
    end
  end
end
