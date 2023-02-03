require "rails_helper"

RSpec.describe "User management", :type => :request do
  let(:user) { create(:user) }

  it "creates a User and redirects to the sessions page" do
    get new_user_path
    expect(response).to render_template(:new)
    
    post users_path, params: { 
      user: { user_name: "Jesse", 
              email: 'jesse@email.com',
              password: '123Test123!+', 
              password_confirmation: '123Test123!+' 
            }}

    expect(response).to redirect_to(root_path)
    follow_redirect!

    expect(response).to render_template(:index)
    expect(response).to have_http_status(200)
    expect(response.body).to include(I18n.t('chatrooms.index.title'))
  end

  it "edits the User and redirects to the root page" do
    log_in(user)
    
    get edit_user_path(user, locale: 'en')
    
    put user_path(user), params: { user: {  
      user_name: "Jesse Pinkman", 
      email: 'jesse@email.com',
      old_password: '123Test123!+', 
      password: '123Test123!', 
      password_confirmation: '123Test123!' 
    }}
      
    expect(response).to redirect_to(root_path)
    follow_redirect!

    expect(response).to render_template(:index)
    expect(response).to have_http_status(200)
    expect(response.body).to include(I18n.t('chatrooms.index.blank_chatrooms'))
  end
end