# frozen_string_literal: true

FactoryBot.define do
  factory :chatroom_user do
    chatroom { Chatroom.take || create(:chatroom) }
    user { User.take || create(:user) }
  end
end
