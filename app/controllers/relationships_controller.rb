class RelationshipsController < ApplicationController
	def index
		if current_owner != nil
			@relationships = Relationship.order("created_at ASC").all
     # puts '=================='
     # puts 'Relationships in relationships#index'
     # puts @relationships
     # puts '=================='
		else
			redirect_to new_session_path #redirects user to new session path if no owner is logged in
		end
	end
	def new
		if current_owner != nil
			@relationship = Relationship.new

			#Find all dogs to select from, if you're coming from the relationship page, which means there won't be a dog id in the params
			if params[:dog_id] == nil
				@dog_select = Dog.all
				@users_not_already_owners = Owner.all
			else #otherwise only show the dog you're current coming from (assuming it's the show page)
				# raise params.inspect
				@dog_select = Dog.where(id: params[:dog_id])
				# Saves owner id of all the owners of current dog in an array
				@existing_owners_array = Relationship.where(dog_id: params[:dog_id]).pluck('owner_id')
				# Finds all owners that are not part of the existing owners array, that we found above
				# This is what the collection select will be on
				@users_not_already_owners = Owner.where.not(id: @existing_owners_array)

			end
			if Relationship.where(dog_id: params[:dog_id], owner_id: current_owner.id).first != nil
				#allows current user to view the new relationship page if they are an owner of the dog
				@is_dog_owner = true
			else
				@is_dog_owner=false
			end		
		else
			redirect_to new_session_path #redirects user to new session path if no owner is logged in
		end
	end
	def edit
		if current_owner != nil
			@relationship = Relationship.find(params[:id])
			@is_dog_admin = Relationship.where(dog_id: @relationship.dog_id, owner_id: current_owner.id).first.is_dog_admin
		else
			redirect_to new_session_path #redirects user to new session path if no owner is logged in
		end
	end
	def create

		@relationship = Relationship.create(params.require(:relationship).permit(:dog_id, :owner_id, :is_dog_admin))
		if @relationship.save
			redirect_to dog_path(@relationship.dog)
		else
			render 'new'
		end
	end
	def update
		@relationship = Relationship.find(params[:id])
		#For update, I'm only letting them update the is dog admin part. I don't want to remove a relationship unless it's from the dog_show page
		if @relationship.update_attributes(params.require(:relationship).permit(:is_dog_admin))
			redirect_to dog_path(@relationship.dog)
		else
			render 'new'
		end
	end

	def destroy
		# @relationship = Relationship.find(params[:id])
		puts '======================================================'
		puts params.inspect
		puts '======================================================'
		@relationship = Relationship.where(owner_id: params[:owner_id]).where(dog_id: params[:dog_id]).first
		puts '======================================================'
		puts 'Relationship object found: '
		puts 'Relationship id'
		puts @relationship.id
		puts 'Relationship dogid'
		puts @relationship.dog_id
		puts 'Relationship ownerid'
		puts @relationship.owner_id
		puts '======================================================'
		@relationship.destroy
		redirect_to owner_path(params[:owner_id])
	end
end
