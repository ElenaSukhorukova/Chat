# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ChatroomUser management' do
  let(:user) { create(:user) }
  let(:chatroom) { create(:chatroom) }

  it 'creates association chatroom<->user' do
    log_in(user)
    post chatroom_chatrooms_users_path(chatroom)

    expect(response).to redirect_to(chatroom_path(chatroom, locale: 'en'))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response).to have_http_status(:ok)
    expect(response.body).to include(chatroom.chatroom_name)
    expect(response.body).to include(I18n.t('chatrooms_users.create.success'))
  end

  it 'deletes association chatroom<->user' do
    log_in(user)
    post chatroom_chatrooms_users_path(chatroom)
    delete chatroom_chatrooms_users_path(chatroom)

    expect(response).to redirect_to(chatroom_path(chatroom, locale: 'en'))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response).to have_http_status(:ok)
    expect(response.body).to include(I18n.t('chatrooms_users.destroy.success'))
  end
end
