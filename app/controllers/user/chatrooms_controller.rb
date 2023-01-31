# frozen_string_literal: true

module User
  class ChatroomsController < ApplicationController
    before_action :require_authentication

    def index
      @user = current_user
      @chatrooms = Chatroom.where(user: @user).order(:chatroom_name)
    end
  end
end
