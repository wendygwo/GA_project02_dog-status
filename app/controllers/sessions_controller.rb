class SessionsController < ApplicationController
  def new
    if current_owner != nil
      redirect_to owner_path(current_owner)
    else
    	@owner = Owner.new #Any controller can create something from any other model!
    	# to do. Copy stuff in from authentication lab with a user_created message
      @login = true
    end

  end

  def create
    #getting the username information (unique to each user) the user typed in and searching for them in the database
    c = Owner.where(username: params[:owner][:username]).first 
    #checking if the user was successfully found based on username entered, and that password matches
    if c != nil && c.authenticate(params[:owner][:password])
      session['owner_id'] = c.id.to_s
      #redirect to owner's show view
  		redirect_to owner_path(c)
    else
      # redirect to new login page
      # TO DO: should probably put error message if they're not able to log in
      # redirect_to new_session_path
      redirect_to new_session_path(:error_message => 'Incorrect password or username')
  	end
  end

  def destroy
  	#destroy session cookie
    session.destroy
    #redirect to login page
  	redirect_to new_session_path
  end
end
