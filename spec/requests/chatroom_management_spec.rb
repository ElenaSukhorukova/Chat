require "rails_helper"

RSpec.describe "Chatroom management", :type => :request do
  let(:user) { create(:user) }
  let(:chatroom) { create(:chatroom) }

  it "creates a Chatroom and redirects to the Chatroom's page" do
    log_in(user)
    get new_chatroom_path

    expect(response).to render_template(:new)
  
    post chatrooms_path, params: { chatroom: { chatroom_name: 'Ho-ho and a bottle of rum' } }
    chatroom = Chatroom.last 

    expect(response).to redirect_to(chatroom_path(chatroom, locale: 'en'))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response).to have_http_status(200)
    expect(response.body).to include('Ho-ho and a bottle of rum')
  end

  it "edits the Chatroom and redirect to the show page" do
    log_in(user)  
    get edit_chatroom_path(chatroom, locale: 'en')
    
    put chatroom_path(chatroom), params: { chatroom: { chatroom_name: 'Happy New Year and Marry Christmas!' } }
      
    expect(response).to redirect_to(chatroom_path(chatroom, locale: 'en'))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response).to have_http_status(200)
    expect(response.body).to include('Happy New Year and Marry Christmas!')
  end
end