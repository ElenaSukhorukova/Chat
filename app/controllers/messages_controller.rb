class MessagesController < ApplicationController
  before_action :require_authentication
  before_action :set_variables!

  def create
    return unless ChatroomUser.where(user: @user, chatroom: @chatroom).exists?
    @message = @user.messages.build message_params
  
    if @message.save 
      @message.broadcast_append_to @message.chatroom
    else
      @chatroom = Chatroom.find params[:chatroom_id]
      @users = @chatroom.users.order(:user_name)
      @message ||= @user.messages.build
      @messages = @chatroom.messages.includes(:user)
      render('chatrooms/show', status: :unprocessable_entity)
    end
  end

  private

  def set_variables!
    @user = current_user
    @chatroom = Chatroom.find params[:chatroom_id]
  end

  def message_params
    params.require(:message).permit(:body).merge(chatroom: @chatroom)
  end
end