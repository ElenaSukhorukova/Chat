class ChatroomsUsersController < ApplicationController
  before_action :set_variables!

  def create
    unless ChatroomUser.where(user: @user, chatroom: @chatroom).exists?
      @users = @chatroom.users
      @users << @user
      @user.broadcast_append_to "chatroom_users"
      redirect_to chatroom_path(@chatroom), success: t('.success')
    end
  end

  def destroy
    @chatroom_user = ChatroomUser.find_by(user: @user, chatroom: @chatroom)
    @chatroom_user.destroy
    @users = @chatroom.users 

    @user.broadcast_remove_to "chatroom_users"
    redirect_to chatroom_path(@chatroom), success: t('.success')
  end

  private

  def set_variables!
    @user = current_user
    @chatroom = Chatroom.find params[:chatroom_id]
  end
end
