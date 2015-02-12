class RelationshipsController < ApplicationController
	def index
		@relationships = Relationship.all
	end
	def new
		@relationship = Relationship.new
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
