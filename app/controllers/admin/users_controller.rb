class Admin::UsersController < Admin::AdminController
  def index
    @users = User.paginate(:all, :page => params[:page] || 1, :order => 'created_at DESC')
    # @groups = Group.paginate(:all, :page => params[:page] || 1, :order => 'created_at DESC')
  end
  
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    @user.active = true
    if @user.save
      flash[:notice] = 'The user has been created.'
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:notice] = 'The user has been updated'
      redirect_to :action => 'show', :id => @user
    else
      render :action => 'edit'
    end
  end
  
  def ban
    user = User.find(params[:id])
    unless user.active?
      flash[:notice] = "The user is not active: they have not responded to their activation email.  You cannot ban them."
    else
      flash[:notice] = "#{user.email} has been banned!"
      user.ban!
    end
    redirect_to(:action => 'show', :id => user)
  end
end
