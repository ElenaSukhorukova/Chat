class MessagesController < ApplicationController
  before_action :require_authentication
  before_action :set_user!

  def create
    message = @user.messages.build message_params

    if message.save 
      redirect_to root_path
    end
  end

  private

  def set_user!
    @user = current_user
  end

  def message_params 
    params.require(:message).permit(:body)
  end
end
