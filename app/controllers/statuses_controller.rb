class StatusesController < ApplicationController
  def index
    if current_owner != nil
      @statuses = Status.all
    else
      redirect_to new_session_path
    end
  end #end index method

  def update
    # raise params.inspect
    @dog_daily_status = Status.where(dog_id: params[:status][:dog_id]).last
    if @dog_daily_status.update_attributes(params.require(:status).permit(:is_fed_breakfast, :is_fed_dinner, :is_walked, :num_treats_given, :notes))
      #Notice to be shown on the owner path about successful update
      flash[:notice] = "Update successfully saved"
    else
      #Notice to be shown on the owner path about unsuccessful update
      flash[:notice] = "Update not saved"
    end
    redirect_to owner_path(owner_id: params[:id])
  end #end update method
end
