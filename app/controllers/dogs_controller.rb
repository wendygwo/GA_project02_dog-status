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
	end

	def create
		@dog = Dog.create(params.require(:dog).permit(:dog_name, :breed, :birthday, :food_low_flag, :treats_low_flag, :photo_path))
		if @dog.save #if everything goes smoothly with saving
			redirect_to dogs_path
		else
			render 'new'
		end
	end

	def edit
		@dog=Dog.find(params[:id])
		@owners = @dog.owners
	end

	def update
		@dog=Dog.find(params[:id])
		if @dog.update_attributes(params.require(:dog).permit(:dog_name, :breed, :birthday, :food_low_flag, :treats_low_flag, :photo_path))
			redirect_to dogs_path
		else
			render 'edit'
		end
	end

	def destroy
		@dog = Dog.find(params[:id])
		@dog.destroy
		redirect_to dogs_path
	end
end
