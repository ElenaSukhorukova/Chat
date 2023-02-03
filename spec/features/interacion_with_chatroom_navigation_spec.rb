# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'InteracionWithChatroomNavigations' do
  before do
    @user = create(:user)
    @chatroom1 = create(:chatroom)
    @chatroom2 = create(:chatroom)
    @user2 = create(:user)
    @chatroom3 = Chatroom.create! chatroom_name: 'Breaking Bad', user: @user2
    sign_in(@user)
  end

  describe 'chatrooms\' links' do
    it 'shows all chatrooms\' names' do
      visit root_path

      expect(page).to have_content @chatroom1.chatroom_name
      expect(page).to have_content @chatroom2.chatroom_name
      expect(page).to have_content @chatroom3.chatroom_name
    end

    it 'not shows chatroom 3 name' do
      visit current_user_chatrooms_path

      expect(page).not_to have_content @chatroom3.chatroom_name
    end

    it 'shows chatroom 3 names after attaching to the chantroom' do
      visit chatroom_path(@chatroom3, locale: 'en')
      find_link(I18n.t('chatrooms.show.link.become_participant'), visible: :all).click
      visit current_user_chatrooms_path

      expect(page).to have_content @chatroom1.chatroom_name
      expect(page).to have_content @chatroom2.chatroom_name
      expect(page).to have_content @chatroom3.chatroom_name
    end
  end
end
