# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ChatroomUser do
  let(:chatroom_user) { create(:chatroom_user) }

  describe 'association' do
    it 'belongs a user' do
      expect(chatroom_user.user).to be_an_instance_of(User)
    end

    it 'belongs a chatroom' do
      expect(chatroom_user.chatroom).to be_an_instance_of(Chatroom)
    end
  end
end
