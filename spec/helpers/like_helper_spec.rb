# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LikeHelper do
  describe 'like' do
    let(:user) { create(:user) }
    let(:message) { create(:message) }

    it 'shows heart' do
      expect(helper.heart(message, user)).to eq('🤍')
    end

    it 'shows count of lokes' do
      expect(helper.likes_count(message)).to eq(0)
    end
  end
end
