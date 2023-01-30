class ChatroomsUsersController < ApplicationController
  before_action :set_variables!

  def create
    @chatroom.users << @user unless ChatroomUser.where(user: @user, chatroom: @chatroom).exists?
    @chatroom.broadcast_append_to @chatroom.users
    redirect_to chatroom_path(@chatroom), success: t('.success')
  end

  def destroy
    @chatroom_user = ChatroomUser.find_by(user: @user, chatroom: @chatroom)
    # debugger
    @chatroom_user.destroy
    @chatroom.broadcast_remove_to @chatroom.users
    redirect_to chatroom_path(@chatroom), success: t('.success')
  end

  private

  def set_variables!
    @user = current_user
    @chatroom = Chatroom.find params[:chatroom_id]
  end
end
