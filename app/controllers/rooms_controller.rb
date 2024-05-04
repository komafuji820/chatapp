class RoomsController < ApplicationController
  def new
    @room = Room.new
    @users = User.all.where.not(id: current_user.id)
  end
end
