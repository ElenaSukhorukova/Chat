# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    chatroom { Chatroom.take || create(:chatroom) }
    user { User.take || create(:user) }
    body do
      Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 3)
    end
  end
end
