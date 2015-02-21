class StatusesController < ApplicationController
  def index
    if current_owner != nil
      @statuses = Status.all
    else
      redirect_to new_session_path
    end
  end

  # def show
  #   # @status = Status.where(dog_id: )
  # end

  def new
  end

  def create
  end

  def edit

  end

  def update
    puts '======================================================'
    puts params
    puts '======================================================'
    # raise params.inspect
    @dog_daily_status = Status.where(dog_id: params[:status][:dog_id]).last
    if @dog_daily_status.update_attributes(params.require(:status).permit(:is_fed_breakfast, :is_fed_dinner, :is_walked, :num_treats_given, :notes))
      puts '======================================================'
      puts 'WENT INTO UPDATE DOG STATUS'
      puts '======================================================'
      redirect_to owner_path(owner_id: params[:id])
    else
      redirect_to owern_path(Dog.where(owner_id: params[:id]))
    end
  end
end
