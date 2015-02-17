class RelationshipsController < ApplicationController
	def index
		if current_owner != nil
			@relationships = Relationship.all
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
		else
			redirect_to new_session_path #redirects user to new session path if no owner is logged in
		end
	end
	def create
		# puts '======================================================'
		# raise params.inspect
		# puts '======================================================'
		@relationship = Relationship.create(params.require(:relationship).permit(:dog_id, :owner_id))
		if @relationship.save
			redirect_to relationships_path
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
		# @relationship.destroy
		redirect_to owner_path(params[:owner_id])
	end
end
