# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'InteracionWithChatroomUsers' do
  let(:chatroom) { create(:chatroom) }
  let(:user1) { User.create! user_name: 'Walter', email: 'walter@email.com', password: '123Test123!+' }
  let(:user2) { User.create! user_name: 'Jesse', email: 'jesse@email.com', password: '123Test123!+' }
  let(:user3) { User.create! user_name: 'Hank', email: 'hank@email.com', password: '123Test123!+' }

  describe 'attaching to the chatroom' do
    it "shows users' names and flash afret clicking on the button to attach" do
      sign_in(user1)
      visit chatroom_path(chatroom, locale: 'en')
      find_link(I18n.t('chatrooms.show.link.become_participant'), visible: :all).click
      sign_out(user1)

      sign_in(user2)
      visit chatroom_path(chatroom, locale: 'en')
      find_link(I18n.t('chatrooms.show.link.become_participant'), visible: :all).click
      sign_out(user2)

      sign_in(user3)
      visit chatroom_path(chatroom, locale: 'en')
      find_link(I18n.t('chatrooms.show.link.become_participant'), visible: :all).click

      expect(page).to have_content user1.user_name
      expect(page).to have_content user2.user_name
      expect(page).to have_content user3.user_name
      expect(page).to have_content I18n.t('chatrooms_users.create.success')
    end
  end

  describe 'detaching to the chatroom' do
    it 'shows flash afret clicking on the button to detach' do
      sign_in(user1)
      visit chatroom_path(chatroom, locale: 'en')
      find_link(I18n.t('chatrooms.show.link.become_participant'), visible: :all).click
      find_link(I18n.t('chatrooms.show.link.exit_from_participants'), visible: :all).click

      expect(page).to have_content I18n.t('chatrooms_users.destroy.success')
      expect(page).not_to have_content I18n.t('chatrooms.show.link.exit_from_participants')
    end
  end
end
