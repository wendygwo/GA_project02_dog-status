class OwnersController < ApplicationController
	def index
		@owners = Owner.all
	end
	def show
		@owner = Owner.find(params[:id])
		@dogs = @owner.dogs #This finds all the dogs for the current owner
	end
	def new
		@owner = Owner.new
	end
	def create
		@owner=Owner.create(params.require(:owner).permit(:first_name, :last_name, :picture_path,:password)) #added for authentication
			if @owner.save
				# redirect_to owners_path
				redirect_to new_session_path(owner_created: 'true') #added for authentication
			else
				render 'new'
				#to do - need to redirect back to new owner path
			end
	end
	def edit
		@owner = Owner.find(params[:id])
	end
	def update
		@owner = Owner.find(params[:id])
		if @owner.update_attributes(params.require(:owner).permit(:first_name, :last_name, :picture_path,:password))
			redirect_to owner_path
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
