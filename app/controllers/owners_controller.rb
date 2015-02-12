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
		@owner=Owner.create(params.require(:owner).permit(:first_name, :last_name, :picture_path))
			if @owner.save
				redirect_to owners_path
			else
				render 'new'
			end
	end
	def edit
		@owner = Owner.find(params[:id])
	end
	def update
		@owner = Owner.find(params[:id])
		if @owner.update_attributes(params.require(:owner).permit(:first_name, :last_name, :picture_path))
			redirect_to owners_path
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
