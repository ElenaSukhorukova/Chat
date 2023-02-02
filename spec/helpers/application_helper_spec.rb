# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper do
  describe 'full title' do
    it 'shows full title of the page' do
      expect(helper.full_title('Title')).to eq("Title | #{I18n.t('site_name')}")
    end
  end

  describe "model's attribute" do
    it "shows message's attribute" do
      expect(helper.attribute_model(Message.new, :body)).to eq(I18n.t('activerecord.attributes.message.body'))
    end
  end

  describe 'path' do
    it 'shows path' do
      expect(helper.params_plus(locale: 'en')).to eq('locale' => 'en')
    end
  end
end
