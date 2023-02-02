# frozen_string_literal: true

def sign_in(user)
  visit new_session_path(locale: 'en')

  within('#session_form') do
    fill_in :email, with: user.email
    fill_in :password, with: user.password
    check(:remember_me)
  end

  click_button I18n.t('sessions.new.form.submit')
end
