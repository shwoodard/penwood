require 'gcal4ruby'

class Admin::CalendarController < Admin::AdminController
  def index
    @events = GCal4Ruby::Calendar.find(service, "Penwood Tentative Appointments", {:scope => :first}).events
  end
  
  def login
    session[:google_account_token] = params[:token]
    redirect_to :action => 'index'
  end
  
  private
  def service
    service = GCal4Ruby::Service.new
    service.authenticate('doug@penwoodpartners.com', 'daw7852')
    service
  end
end
