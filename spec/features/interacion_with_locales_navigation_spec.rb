require 'rails_helper'

RSpec.feature "InteracionWithLocalesNavigations", type: :feature do
  describe 'localess\' links', :last do 
    it 'shows right loclaes\' routes' do 
      visit root_path
      find_link(I18n.t('ru'), visible: :all).click 
      expect(page).to have_current_path(new_session_path(locale: 'ru'))

      find_link('Английский', visible: :all).click 
      expect(page).to have_current_path(new_session_path(locale: 'en'))
    end
  end
end
