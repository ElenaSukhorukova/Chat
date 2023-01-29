class ChatroomsController < ApplicationController
  before_action :require_authentication
  before_action :set_user!, except: %i[edit update]
  before_action :set_chatroom!, except: %i[index]

  def edit 
  end

  def update
    if @chatroom.update chatroom_params
      redirect_to chatroom_path(@chatroom), success: t('.success')
    end
  end

  def new
    @chatroom = Chatroom.new
  end

  def create
    @chatroom = @user.chatrooms.build chatroom_params

    if @chatroom.save
      @chatroom.broadcast_append_to :chatrooms
      redirect_to chatroom_path(@chatroom), success: t('.success')
    end
  end

  def index
    @chatrooms = Chatroom.all.order(:chatroom_name)
  end

  def show
    @messages = Message.all.includes(:user)
  end

  private

  def set_user!
    @user = current_user
  end

  def set_chatroom!
    @chatroom = Chatroom.find_by(chatroom_name: params[:chatroom_name])
  end

  def chatroom_params
    params.require(:chatroom).permit(:chatroom_name)
  end
end
