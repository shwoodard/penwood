class PaymentsController < ApplicationController
  before_filter :require_user
  
  def new
  end
end
