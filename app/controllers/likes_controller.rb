class LikesController < ApplicationController
  
  def create
    message = Message.find params[:message_id]
    chatroom = message.chatroom
    user = current_user

    @like = message.likes.build
    @like.user = user

    if @like.save
      @like.broadcast_append_to @like.message, :likes, target: 'likes',
      partial: "messages/message", locals: { message: @like.message }
      redirect_to chatroom_path(chatroom)
    end
  end

  def destroy
    @like = Like.find params[:id]
    chatroom = @like.message.chatroom
    @like.destroy
    @like.broadcast_remove_to @like.message, :likes, target: 'likes'
    redirect_to chatroom_path(chatroom)
  end
end
