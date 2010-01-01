require 'gcal4ruby'

class AppointmentsController < ApplicationController
  before_filter :require_user

  def index
  end

  def new
  end
  
  def create
    @service = GCal4Ruby::Service.new
    @service.authenticate('doug@penwoodpartners.com', 'daw7852')

    calendar = GCal4Ruby::Calendar.find(@service, "Penwood Appointments", {:scope => :first})
    
    event = GCal4Ruby::Event.new(calendar)
    # event.title = "Soccer Game"
    event.start = Time.parse("#{params[:appointment][:start_date]} #{params[:appointment][:start_time]}")
    event.end = Time.parse("#{params[:appointment][:end_date]} #{params[:appointment][:end_time]}")
    # event.where = "Merry Playfields"
    event.save
  end
end
