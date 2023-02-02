# frozen_string_literal: true

module CurrentUser
  class ChatroomsController < ApplicationController
    before_action :require_authentication

    def index
      @user = current_user
      @chatrooms = Chatroom.where(id:
        Chatroom.where(user: @user).pluck(:id).concat(ChatroomUser.where(user: @user).pluck(:chatroom_id)))
    end
  end
end
