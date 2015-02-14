class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #this makes the current user available in every view
  helper_method :current_owner 
  #this makes the current user available to ALL controllers, but NOT view templates
  def current_owner
  	Owner.where(id: session['owner_id']).first
  end
end
