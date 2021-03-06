require 'gcal4ruby'

class AppointmentsController < ApplicationController
  before_filter :require_user
  verify :xhr => true, :only => [:tentative_appointments, :confirmed_appointments]

  def index
  end
  
  def tentative_appointments
    @tentative_appointments = GCal4Ruby::Calendar.find(service, "Penwood Tentative Appointments", {:scope => :first}).events.find_all {|event| event.attendees.any? {|attendee| attendee[:email] == current_user.email}}
    render :layout => false
  end
  
  def confirmed_appointments
    @confirmed_appointments = GCal4Ruby::Calendar.find(service, "Penwood Appointments", {:scope => :first}).events.find_all {|event| event.attendees.any? {|attendee| attendee[:email] == current_user.email}}
    render :layout => false
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
    
    if params[:appointment][:start_date].blank? || params[:appointment][:start_time].blank? || 
      params[:appointment][:end_date].blank? || params[:appointment][:end_time].blank?
      flash.now[:notice] = "All date and time fields are required"
      render :action => 'new' and return
    end
    
    if event.save
      AppointmentNotifier.deliver_new_appointment_email(params, current_user)
      flash[:notice] = 'Your event request has been submitted.  Thank you.'
      redirect_to :action => 'index'
    else
      flash.now[:notice] = 'Something went wrong with saving your event.  Please try again.'
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
