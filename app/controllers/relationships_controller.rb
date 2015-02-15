class RelationshipsController < ApplicationController
	def index
		if current_owner != nil
			@relationships = Relationship.all
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
		@relationship = Relationship.create(params.require(:relationship).permit(:dog_id, :owner_id))
		if @relationship.save
			redirect_to relationships_path
		else
			render 'new'
		end
	end

	def destroy
		@relationship = Relationship.find(params[:id])
		@relationship.destroy
		redirect_to relationships_path
	end
end
