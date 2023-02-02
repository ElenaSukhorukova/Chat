# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'InteracionWithSessions' do
  let(:user) { create(:user) }

  describe 'session' do
    it 'shows a session new page and a flash' do
      visit root_path(locale: 'en')

      expect(page).to have_content I18n.t('global.flash.should_signed_in')

      expect(find_link('Sign up')).to have_content('Sign up')
      expect(page).to have_content('Email')
    end

    it 'enters to the profile' do
      visit new_session_path(locale: 'en')

      within('#session_form') do
        fill_in :email, with: user.email
        fill_in :password, with: user.password
        check(:remember_me)
      end

      click_button I18n.t('sessions.new.form.submit')

      expect(page).to have_content I18n.t('sessions.create.flashes.welcome', user_name: user.user_name)
      expect(page).to have_current_path(root_path(locale: 'en'))
    end

    it 'exit from the profile' do
      visit root_path(locale: 'en')
      sign_in(user)
      find_by_id('navigation').click_link(I18n.t('global.menu.log_out'))
      expect(page).to have_content(I18n.t('sessions.destroy.flash'))
    end
  end
end
