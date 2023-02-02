# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'InteracionWithChatrooms' do
  let(:user) { create(:user) }
  let(:chatroom) { create(:chatroom) }

  before { sign_in(user) }

  describe 'create' do
    it 'shows the button for create a new chatroom and cliks on it' do
      visit root_path(locale: 'en')

      find_link(I18n.t('chatrooms.index.link.new'), visible: :all).click
      expect(page).to have_content(I18n.t('chatrooms.new.title'))
    end

    it 'chreates a new chatroom and flash' do
      visit new_chatroom_path(locale: 'en')
      chatroom_name = 'Name of a new chatroom'

      within('#new_chatroom') { fill_in :chatroom_chatroom_name, with: chatroom_name }
      click_button I18n.t('chatrooms.form.new.submit')

      expect(page).to have_current_path(chatroom_path(Chatroom.last, locale: 'en'))
      expect(page).to have_content I18n.t('chatrooms.create.success')
      expect(page).to have_content chatroom_name
    end
  end

  describe 'edit' do
    let(:user_chatroom) { Chatroom.create! chatroom_name: 'Ho-ho. Happy Christmas!', user: user }

    it 'shows an edit page' do
      visit chatroom_path(user_chatroom, locale: 'en')

      find_link(I18n.t('chatrooms.show.link.edit'), visible: :all).click
      expect(page).to have_content(I18n.t('chatrooms.edit.title', chatroom: user_chatroom.chatroom_name))
    end

    it 'edit the chatroom' do
      visit edit_chatroom_path(user_chatroom, locale: 'en')

      within("#edit_chatroom_#{user_chatroom.id}") { fill_in :chatroom_chatroom_name, with: 'Happy New Year!' }
      click_button I18n.t('chatrooms.form.edit.submit')

      expect(page).to have_content('Happy New Year!')
    end
  end

  describe 'delete' do
    let(:user_chatroom) { Chatroom.create! chatroom_name: 'Ho-ho. Happy Christmas!', user: user }

    it 'root page without a deleted chatroom after clicking of delete button' do
      visit chatroom_path(user_chatroom, locale: 'en')

      find_link(I18n.t('chatrooms.show.link.delete')).click

      expect(page).to have_content I18n.t('chatrooms.destroy.success')
      expect(page).to have_current_path(root_path(locale: 'en'))
      expect(page).not_to have_content user_chatroom.chatroom_name
    end
  end
end
