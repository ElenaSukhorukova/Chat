# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Chatroom do
  let(:chatroom1) { create(:chatroom) }

  before do
    create(:chatroom)
  end

  it 'returns chatroom\'s name' do
    expect(chatroom1.chatroom_name).to be_an_instance_of(String)
  end

  describe 'validation' do
    it { is_expected.to validate_uniqueness_of(:chatroom_name) }
    it { is_expected.to validate_presence_of(:chatroom_name) }
  end

  describe 'association' do
    it { expect(chatroom1).to have_many(:users).through(:chatroom_users) }
  end
end
