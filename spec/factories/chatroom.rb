# frozen_string_literal: true

FactoryBot.define do
  factory :chatroom do
    user { User.take || create(:user) }
    chatroom_name { Faker::Hobby.activity }
  end
end
