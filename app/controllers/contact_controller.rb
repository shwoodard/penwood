class ContactController < ApplicationController
  def index
    redirect_to dialogs_path
    @user_session = UserSession.new unless current_user_session
  end
end
