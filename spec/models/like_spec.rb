# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Like do
  let(:like) { create(:like) }

  describe 'association' do
    it 'belongs a user' do
      expect(like.user).to be_an_instance_of(User)
    end

    it 'belongs a message' do
      expect(like.message).to be_an_instance_of(Message)
    end
  end
end
