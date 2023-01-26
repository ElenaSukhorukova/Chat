class ChatroomController < ApplicationController
  before_action :require_authentication
  before_action :set_user!

  def index
    @messages = Message.all.includes(:user)
  end

  private

  def set_user!
    @user = current_user
  end
end
