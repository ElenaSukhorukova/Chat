# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'InteracionWithChatroomMessages' do
  let(:chatroom) { create(:chatroom) }
  let(:user) { create(:user) }

  before do
    sign_in(user)
    visit chatroom_path(chatroom, locale: 'en')
    find_link(I18n.t('chatrooms.show.link.become_participant'), visible: :all).click
  end

  describe 'creating' do
    it 'shows created message' do
      within('#new_message') { fill_in :message_body, with: 'New message' }
      find_by_id('new_message').click_button('button')
      visit chatroom_path(chatroom, locale: 'en')

      expect(page).to have_content 'New message'
    end
  end

  describe 'liking' do
    it 'shows liked message' do
      message = Message.create! body: Faker::Lorem.paragraph(sentence_count: 2, supplemental: true, random_sentences_to_add: 3),
                                user: user, chatroom: chatroom
      count_likes = message.likes.count
      visit chatroom_path(chatroom, locale: 'en')

      find_by_id("message_#{message.id}").find('a').click
      visit chatroom_path(chatroom, locale: 'en')

      expect(page).to have_content '🧡'
      expect(message.likes.count).to be > count_likes
    end
  end
end
