class MessagesController < ApplicationController
  def index
    @rooms = current_user.rooms
    @room = Room.find(params[:room_id])
    @message = Message.new
    @messages = @room.messages.includes(:user)
  end

  def create
    @room = Room.find(params[:room_id])
    @message = @room.messages.new(message_params)
    if @message.save
      redirect_to room_messages_path(@message.room.id)
    else
      @rooms = current_user.rooms
      @messages = @room.messages.includes(:user)
      render :index, status: :unprocessable_entity
    end
  end

  private
  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end
end
