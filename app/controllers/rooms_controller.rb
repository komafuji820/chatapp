class RoomsController < ApplicationController
  def new
    @room = Room.new
    @users = User.all.where.not(id: current_user.id)
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to root_path
    else
      @users = User.all.where.not(id: current_user.id)
      render :new, status: :unprocessable_entity
    end
  end

  private
  def room_params
    params.require(:room).permit(:name, user_ids:[])
  end
end
