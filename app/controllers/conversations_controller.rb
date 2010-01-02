class ConversationsController < ApplicationController
  before_filter :require_user
  
  def index
    @conversation = Conversation.new
    @conversation.conversation_entries.build
    User.basic_admin.each {|u| @conversation.user_conversations.build(:user => u)}
  end
  
  def show
    @conversation = Conversation.find(params[:id])
  end
  
  def new
    @conversation = Conversation.new
    @conversation.user_conversations.build(:user => current_user, :creator => true)
  end
  
  def create
    @conversation = Conversation.new(params[:conversation])
    @conversation.user_conversations.build(:user => current_user, :creator => true)
    if @conversation.save
      flash[:notice] = 'Your conversation has been created.'
      @conversation.deliver_invitations!
      redirect_to @conversation
    else
      @conversation.user_conversations.clear
      User.basic_admin.each {|u| @conversation.user_conversations.build(:user => u)}
      render :action => params[:quick] ? 'index' : 'new'
    end
  end
end
