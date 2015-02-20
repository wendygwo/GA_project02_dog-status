class OwnersController < ApplicationController
	def index
				@owners = Owner.order("created_at ASC").all

	end
	def show
		if current_owner != nil
			@owner = Owner.find(params[:id])
			@dogs = @owner.dogs #This finds all the dogs for the current owner
		else
			redirect_to new_session_path #redirects user to new session path if no owner is logged in
		end
	end
	def new
		@owner = Owner.new
	end
	def create
		#added for authentication
		# raise params.inspect
		@owner=Owner.create(params.require(:owner).permit(:username, :first_name, :last_name,:password,:password_confirmation,:image)) 
		
		if is_current_owner_site_admin
			# Only set the site admin flag based on user input if the user adding them is an admin
			@owner.is_site_admin = params[:owner][:is_site_admin]
		else
			# Make new users not site admin, by default
			@owner.is_site_admin = false
		end
		if @owner.save
			#redirect to owner show page and create session cookie if user successfully created
			session['owner_id'] = @owner.id.to_s
			redirect_to owner_path(@owner)
		else
			# redirect_to new_owner_path
			render 'new'
			# puts '=================================='
			# puts 'Errors'
			# puts @owner.errors
			# puts 'Full error messages'
			# puts @owner.errors.full_messages
			# puts '=================================='
		end
	end
	def edit
		if current_owner != nil
			@owner = Owner.where(id: params[:id]).first
		else
			redirect_to new_session_path
		end
	end
	def update
		@owner = Owner.find(params[:id])
		if @owner.update_attributes(params.require(:owner).permit(:username, :first_name, :last_name,:password,:password_confirmation, :image, :is_site_admin))
			redirect_to owner_path(current_owner)
		else
			render 'edit'
		end
	end
	def destroy
		@owner=Owner.find(params[:id])
		@owner.destroy
		redirect_to owners_path
	end
end
