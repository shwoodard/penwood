class ConversationsController < ApplicationController
  before_filter :require_user
  
  def index
    
  end
  
  def new
    @conversation = Conversation.new
    @conversation.user_conversations.build(:user => current_user, :creator => true)
  end
  
  def create
    @conversation = Conversation.new(params[:conversation])
    if @conversation.save
      flash[:notice] = 'Your conversation has been created.'
      @conversation.deliver_invitations!
      redirect_to @conversation
    else
      render :action => 'new'
    end
  end
end
