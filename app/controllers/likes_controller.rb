class LikesController < ApplicationController
  
  def create
    message = Message.find params[:message_id]
    user = current_user

    @like = message.likes.build
    @like.user = user

    if @like.save
      @like.broadcast_append_to "messages_likes"
      redirect_to chatroom_path(@chatroom)
    end
  end

  def destroy
    @like = Like.find params[:id]
    chatroom = @like.message.chatroom
    @like.destroy
    @like.broadcast_remove_to "messages_likes"
    redirect_to chatroom_path(chatroom)
  end
end
