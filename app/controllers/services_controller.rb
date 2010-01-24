class ServicesController < ApplicationController
  def index
    redirect_to :action => 'couples'
  end
  
  def couples
  end
  
  def organizations
  end
  
  def families
  end
end
