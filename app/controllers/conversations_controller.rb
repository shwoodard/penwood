class ConversationsController < ApplicationController
  verify :xhr => true, :only => :new_quick_note
  before_filter :require_user
  before_filter :require_conversation_member, :only => :show
  
  def index
    @conversation = Conversation.new
    @conversation.conversation_entries.build
    User.basic_admin.find_all{|usr| usr.name == 'Doug' || usr.name == 'Terry'}.each {|u| @conversation.user_conversations.build(:user => u)}
  end
  
  def list
    @conversations = current_user.conversations
    unless @conversations.any?
      flash[:notice] = 'You do not have any conversations.  Create one.'
      redirect_to :action => 'index' and return
    end
  end
  
  def show
    @conversation.conversation_entries.each {|ce| ce.read_by = current_user.email }
    @conversation.save
  end
  
  def new
    @conversation = Conversation.new
    @conversation.user_conversations.build(:user => current_user, :creator => true)
  end
  
  def new_quick_note
    @conversation = Conversation.find(params[:id])
    @conversation.conversation_entries.build
    render :layout => false
  end
  
  def create
    @conversation = Conversation.new(params[:conversation])
    @conversation.user_conversations.build(:user => current_user, :creator => true)
    if @conversation.save
      flash[:notice] = 'Your conversation has been created.'
      redirect_to @conversation
    else
      @conversation.user_conversations.clear
      User.basic_admin.each {|u| @conversation.user_conversations.build(:user => u)}
      render :action => params[:quick] ? 'index' : 'new'
    end
  end
  
  def edit
    @conversation = Conversation.find(params[:id])
  end
  
  def update
    @conversation = Conversation.find(params[:id])
    if @conversation.update_attributes(params[:conversation])
      flash[:notice] = "Thank you"
    else
      flash[:notice] = "Something went wrong.  Please try again later"
    end
    redirect_to @conversation
  end
  
  private
  def require_conversation_member
    @conversation = Conversation.find(params[:id])
    logger.info "#{@conversation.users.include?(current_user)}"
    unless @conversation.users.include?(current_user)
      flash[:notice] = "You are not a member of that conversation."
      redirect_to root_path
    end
  end
end
