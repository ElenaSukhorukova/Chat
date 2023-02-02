# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'chatrooms/new' do
  it 'infers the controller action' do
    expect(controller.request.path_parameters[:action]).to eq('new')
    expect(controller.request.path_parameters[:controller]).to eq('chatrooms')
    expect(controller.controller_path).to eq('chatrooms')
  end
end
