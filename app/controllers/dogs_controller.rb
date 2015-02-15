class DogsController < ApplicationController
	def index
		if current_owner != nil
			@dogs = Dog.all
		else
			redirect_to new_session_path
		end
	end

	def show
		if current_owner != nil
			@dog = Dog.find(params[:id])
			@owners = @dog.owners #This finds all the owners of the current dog
		else
			redirect_to new_session_path
		end
	end

	def new
		if current_owner != nil
			@dog=Dog.new
			@owner = Owner.find(params[:owner_id])
		else
			redirect_to new_session_path
		end
	end

	def create
		@dog = Dog.create(params.require(:dog).permit(:dog_name, :breed, :birthday, :food_low_flag, :treats_low_flag, :photo_path))
    @owner = Owner.find(params[:dog][:dog_owner_id])
		if @dog.save #if everything goes smoothly with saving
			#creates relationship between the current dog and the owner that requested this dog be created
			@dog.relationships.create(owner: @owner) 
			#redirects to the show page of the owner who requested the dog be added
			redirect_to owner_path(@owner) 
		else
		  render 'edit'
			#redirect_to new_owner_path
		end
	end

	def edit
		if current_owner != nil
			@dog=Dog.find(params[:id])
		else
			redirect_to new_session_path
		end
	end

	def update
		@dog=Dog.find(params[:id])
		if @dog.update_attributes(params.require(:dog).permit(:dog_name, :breed, :birthday, :food_low_flag, :treats_low_flag, :photo_path))
			# send back to owner's show page
			redirect_to owner_path(current_owner)
		else
			render 'edit'
		end
	end

	def destroy
		@dog = Dog.find(params[:id])
		@dog.destroy
		redirect_to owner_path(current_owner)
	end
end
