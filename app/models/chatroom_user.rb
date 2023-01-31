# frozen_string_literal: true

class ChatroomUser < ApplicationRecord
  belongs_to :user
  belongs_to :chatroom
end
