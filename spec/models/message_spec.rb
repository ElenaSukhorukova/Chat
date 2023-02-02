# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Message do
  let(:message) { create(:message) }

  it 'returns message\'s body' do
    expect(message.body).to be_an_instance_of(String)
  end

  describe 'validation' do
    it { is_expected.to validate_presence_of(:body) }
  end

  describe 'association' do
    it { is_expected.to have_many :likes }

    it 'belongs a user' do
      expect(message.user).to be_an_instance_of(User)
    end

    it 'belongs a chatroom' do
      expect(message.chatroom).to be_an_instance_of(Chatroom)
    end
  end
end
