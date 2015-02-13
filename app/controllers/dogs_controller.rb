class DogsController < ApplicationController
	def index
		@dogs = Dog.all
	end

	def show
		@dog = Dog.find(params[:id])
		@owners = @dog.owners #This finds all the owners of the current dog
	end

	def new
		@dog=Dog.new
		@owner = Owner.find(params[:owner_id])
	end

	def create
		@dog = Dog.create(params.require(:dog).permit(:dog_name, :breed, :birthday, :food_low_flag, :treats_low_flag, :photo_path))
     puts '======================================================'
     puts params.inspect #This will show up on the server outputs. A debugging tool
     puts params[:dog][:dog_owner_id].inspect
     puts '======================================================'
     @owner = Owner.find(params[:dog][:dog_owner_id])
		if @dog.save #if everything goes smoothly with saving
			@dog.relationships.create(owner: @owner) #creates relationship between the current dog and the owner that requested this dog be created
			redirect_to owner_path(@owner) #redirects to the show page of the owner who requested the dog be added
		else
			render 'new'
		end
	end

	def edit
		@dog=Dog.find(params[:id])
		# @owners = @dog.owners
	end

	def update
		@dog=Dog.find(params[:id])
		if @dog.update_attributes(params.require(:dog).permit(:dog_name, :breed, :birthday, :food_low_flag, :treats_low_flag, :photo_path))
			redirect_to owner_path(id: session['owner_id'])
		else
			render 'edit'
		end
	end

	def destroy
		@dog = Dog.find(params[:id])
		@dog.destroy
		redirect_to dogs_path
	end

	# def dog_params
 #    params.require(:dog).(:name,:breed)
	# end	
end
