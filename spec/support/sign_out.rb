# frozen_string_literal: true

def sign_out(_user)
  visit root_path(locale: 'en')

  find_by_id('navigation').click_link(I18n.t('global.menu.log_out'))
end
