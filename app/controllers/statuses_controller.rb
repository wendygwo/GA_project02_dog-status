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
  end
end
