require 'gcal4ruby'
require 'uuidtools'

class AppointmentsController < ApplicationController
  before_filter :require_user

  def index
    @tentative_appointments = GCal4Ruby::Calendar.find(service, "Penwood Tentative Appointments", {:scope => :first}).events.find_all {|event| event.attendees.any? {|attendee| attendee[:email] == current_user.email}}
    @confirmed_appointments = GCal4Ruby::Calendar.find(service, "Penwood Appointments", {:scope => :first}).events.find_all {|event| event.attendees.any? {|attendee| attendee[:email] == current_user.email}}
  end

  def new
  end
  
  def show
  end
  
  def create
    calendar = GCal4Ruby::Calendar.find(service, "Penwood Tentative Appointments", {:scope => :first})
    
    event = GCal4Ruby::Event.new(calendar)
    event.title = "Penwood Partners Appointment"
    event.start = Time.parse("#{params[:appointment][:start_date]} #{params[:appointment][:start_time]}")
    event.end = Time.parse("#{params[:appointment][:end_date]} #{params[:appointment][:end_time]}")
    event.attendees = [{:name => current_user.name, :email => current_user.email}]
    event.content = params[:appointment][:note]
    event.id = UUIDTools::UUID.random_create.to_s
    
    if event.save
      flash[:notice] = 'Your event request has been submitted.  Thank you.'
      redirect_to :action => 'show', :id => event.id
    else
      render :action => 'new'
    end
  end
  
  def service
    @service ||= begin
      s = GCal4Ruby::Service.new
      s.authenticate('doug@penwoodpartners.com', 'daw7852')
      s
    end
  end
end
