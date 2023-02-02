# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    message { Message.take || create(:message) }
    user { User.take || create(:user) }
  end
end
