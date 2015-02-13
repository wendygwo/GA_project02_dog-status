class SessionsController < ApplicationController
  def new
  	@owner = Owner.new #Any controller can create something from any other model!
  	# to do. Copy stuff in from authentication lab with a user_created message
  end

  def create
  	o = Owner.where(username: params[:owner][:username]).first #picking up the username has
  	if o != nil && o.authenticate(params[:owner][:password])
  		session['owner_id'] = o.id.to_s
  		redirect_to owner_path(o)
  	end
  end

  def destroy
  	session.destroy
  	redirect_to new_session_path
  end
end
