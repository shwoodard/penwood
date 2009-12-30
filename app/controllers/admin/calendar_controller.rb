class Admin::CalendarController < Admin::AdminController
  def index
  end
  
  def login
    session[:google_account_token] = params[:token]
    # redirect_to :action => 'index'
  end
end
