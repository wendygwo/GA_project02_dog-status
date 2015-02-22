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
			# raise params.inspect
			@dog = Dog.find(params[:id])
			@owners = @dog.owners #This finds all the owners of the current dog
			# @is_dog_admin = Relationship.where(dog_id: @dog.id, owner_id: current_owner.id).first.is_dog_admin
			current_owner_relationship = Relationship.where(dog_id: @dog.id, owner_id: current_owner.id).first;
			if current_owner_relationship != nil
				@is_dog_admin=current_owner_relationship.is_dog_admin;
			else
				@is_dog_admin=false;
			end
			#grab the last record, because that's the most updated one
			@dog_daily_status = Status.where(dog_id: @dog.id).last
			#TO DO - add in conditionals here, so that if the date of the last update is not the same as the current date, create a new record
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
		@dog = Dog.create(params.require(:dog).permit(:dog_name, :breed, :birthday, :food_low_flag, :treats_low_flag, :image))
    @owner = Owner.find(params[:dog][:dog_owner_id])
		if @dog.save #if everything goes smoothly with saving
			#creates relationship between the current dog and the owner that requested this dog be created
			#Automatically makes the owner who added this relationship as a dog_admin
			@dog.relationships.create(owner: @owner, is_dog_admin:true) 
			# Create the first status record when a new dog is created
			@status = @dog.statuses.create(is_fed_breakfast:false, is_fed_dinner:false, is_walked:false, num_treats_given:2, notes:'No notes.')
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
		if @dog.update_attributes(params.require(:dog).permit(:dog_name, :breed, :birthday, :food_low_flag, :treats_low_flag, :image))
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
