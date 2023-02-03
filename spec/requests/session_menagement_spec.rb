# frozen_string_literal: true

RSpec.describe 'Session management' do
  let(:user) { create(:user) }

  it 'creates a session and shows root path' do
    get new_session_path

    post session_path, params: { email: user.email, password: '123Test123!+' }

    expect(response).to redirect_to(root_path)
    follow_redirect!

    expect(response).to render_template(:index)
    expect(response).to have_http_status(:ok)
    expect(response.body).to include(I18n.t('chatrooms.index.link.new'))
  end

  it 'delete the session and shows root path' do
    login_in(user)
    delete session_path

    expect(response).to redirect_to(new_session_path)
    follow_redirect!

    expect(response).to render_template(:new)
    expect(response).to have_http_status(:ok)
    expect(response.body).to include(I18n.t('sessions.new.title'))
  end
end
