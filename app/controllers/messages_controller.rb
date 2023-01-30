class MessagesController < ApplicationController
  before_action :require_authentication
  before_action :set_variables!

  def create
    message = @user.messages.build message_params

    if message.save 
      @chatroom.broadcast_append_to @message.chatroom
      redirect_to chatroom_path(@chatroom)
    end
  end

  private

  def set_variables!
    @user = current_user
    @chatroom = Chatroom.find_by chatroom_name: params[:chatroom_id]
  end

  def message_params
    params.require(:message).permit(:body).merge(chatroom: @chatroom)
  end
end