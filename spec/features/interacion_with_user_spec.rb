# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'InteracionWithUsers' do
  let(:user) { create(:user) }

  describe 'registration' do
    it 'shows a registreation page' do
      visit root_path(locale: 'en')

      find_link(I18n.t('global.link.new_user'), visible: :all).click
      expect(page).to have_content(I18n.t('users.new.title'))
    end

    it 'shows root page and greeting a new user' do
      visit new_user_path(locale: 'en')
      expect(page).to have_content(I18n.t('users.new.title'))

      new_user = User.new user_name: 'Jesse', email: 'jesse@email.com', password: '123Test123!+', password_confirmation: '123Test123!+'

      within('#new_user') do
        fill_in :user_user_name, with: new_user.user_name
        fill_in :user_email, with: new_user.email
        fill_in :user_password, with: '123Test123!+'
        fill_in :user_password_confirmation, with: '123Test123!+'
      end
      click_button I18n.t('users.form.new.submit')

      expect(page).to have_content I18n.t('users.create.flash', user_name: new_user.user_name)
      expect(page).to have_current_path(root_path(locale: 'en'))
    end
  end

  describe 'edit' do
    before { sign_in(user) }

    it 'shows an edit user page' do
      visit root_path(locale: 'en')
      find_by_id('navigation').click_link(I18n.t('global.menu.edit_user'))
      expect(page).to have_content(I18n.t('users.edit.title'))
    end

    it 'edits the user and shows flash' do
      visit edit_user_path(user, locale: 'en')

      expect(page).to have_content(I18n.t('users.edit.title'))

      within("#edit_user_#{user.id}") do
        fill_in :user_user_name, with: 'Jesse Pinkman'
        fill_in :user_email, with: user.email
        fill_in :user_old_password, with: '123Test123!+'
        fill_in :user_password, with: '123Test123!'
        fill_in :user_password_confirmation, with: '123Test123!'
      end

      click_button I18n.t('users.form.edit.submit')

      expect(page).to have_content I18n.t('users.update.flash')
    end
  end
end
