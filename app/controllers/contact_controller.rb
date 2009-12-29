class ContactController < ApplicationController
  def index
    @user_session = UserSession.new unless current_user_session
  end
end
