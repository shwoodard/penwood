class WelcomeController < ApplicationController
  def index
  end
  
  def about
  end
  
  def welcome_dialog
    render :layout => false
  end
  
  def dont_show_welcome_dialog
    current_user.update_attribute(:show_welcome_dialog, false)
    render :text => ""
  end
end
