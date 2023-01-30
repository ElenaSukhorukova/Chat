class User::ChatroomsController < ApplicationController
  before_action :require_authentication

  def index
    @user = current_user
    @chatrooms = Chatroom.where(user: @user).order(:chatroom_name)
  end
end