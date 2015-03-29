class PasswordResetsController < ApplicationController
  def new
  end
	def create
	  owner = Owner.find_by_email(params[:email])
	  owner.send_password_reset if owner
	  flash[:notice] = 'E-mail sent with password reset instructions.'
	  redirect_to sessions_welcome_path
	end
	def edit
	  @owner = Owner.find_by_password_reset_token!(params[:id])
	end

	def update
	  @owner = Owner.find_by_password_reset_token!(params[:id])
	  if @owner.password_reset_sent_at < 2.hour.ago
	    flash[:notice] = 'Password reset has expired'
	    redirect_to new_password_reset_path
	  elsif @owner.update(owner_params)
	    flash[:notice] = 'Password has been reset!'
	    redirect_to new_session_path
	  else
	    render :edit
	  end
	end

	private
	  # Never trust parameters from the scary internet, only allow the white list through.
	  def owner_params
	    params.require(:owner).permit(:password)
	  end

end
