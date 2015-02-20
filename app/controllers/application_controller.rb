class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  #this makes the current user available in every view
  helper_method :current_owner
  helper_method :is_current_owner_site_admin
  #this makes the current user available to ALL controllers, but NOT view templates
  def current_owner
  	Owner.where(id: session['owner_id']).first
  end
  def is_current_owner_site_admin
    if current_owner != nil
  	 current_owner.is_site_admin
    else
      return false #returns false for the purpose of creating a new owner when no one is logged in
    end
  end
end
