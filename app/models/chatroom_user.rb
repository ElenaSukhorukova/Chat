class ChatroomUser < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :chatroom
end
