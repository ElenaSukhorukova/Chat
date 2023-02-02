# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  let(:user1) { create(:user) }

  before do
    create(:user)
  end

  it 'returns user\'s name' do
    expect(user1.user_name).to eq('Walter')
  end

  it 'returns user\'s email' do
    expect(user1.email).to be_an_instance_of(String)
  end

  describe 'validation' do
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_presence_of(:user_name) }
    it { is_expected.to validate_presence_of(:email) }

    it 'returns false an invalid password' do
      invalid_password = %w[123 password].sample
      user1.password = invalid_password
      expect(user1.invalid?).to be true
    end

    it 'returns false for the email' do
      invalid_mail = %w[mailamail.com mail.com@mail mailmailcom].sample
      user1.email = invalid_mail
      expect(user1.invalid?).to be true
    end

    it 'returns false for an invalid old password' do
      old_password = '123Test123!'
      user1.update(old_password: old_password)
      expect(user1.invalid?).to be true
    end

    it 'returns true for a valid old password' do
      old_password = '123Test123!+'
      user1.update(old_password: old_password)
      expect(user1.valid?).to be true
    end
  end

  describe 'association' do
    it { is_expected.to have_many :messages }
    it { is_expected.to have_many :chatrooms }
    it { is_expected.to have_many :likes }
    it { expect(user1).to have_many(:chatroom).through(:chatroom_users) }
  end
end
