# frozen_string_literal: true

class ChatroomsController < ApplicationController
  before_action :require_authentication
  before_action :set_user!
  before_action :set_chatroom!, except: %i[new create index]
  before_action :set_users, only: :show

  def index
    @chatrooms = Chatroom.all.order(:chatroom_name)
  end

  def show
    @chatroom = Chatroom.find(params[:id])
    @messages = @chatroom.messages.includes(:user)
    @message = Message.new
  end

  def new
    @chatroom = Chatroom.new
  end

  def edit; end

  def create
    @chatroom = @user.chatrooms.build chatroom_params

    if @chatroom.save
      @chatroom.broadcast_append_to :chatrooms
      redirect_to chatroom_path(@chatroom), success: t('.success')
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    return unless @chatroom.user == @user

    if @chatroom.update chatroom_params
      @chatroom.broadcast_replace_to :chatrooms
      redirect_to chatroom_path(@chatroom), success: t('.success')
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    return unless @chatroom.user == @user

    @chatroom.destroy
    @chatroom.broadcast_remove_to :chatrooms
    redirect_to root_path, success: t('.success')
  end

  private

  def set_user!
    @user = current_user
  end

  def set_chatroom!
    @chatroom = Chatroom.find params[:id]
  end

  def set_users
    @users = @chatroom.users.order(:user_name)
  end

  def chatroom_params
    params.require(:chatroom).permit(:chatroom_name)
  end
end
