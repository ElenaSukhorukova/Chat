# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'sessions/new' do
  it 'infers the controller action' do
    expect(controller.request.path_parameters[:action]).to eq('new')
    expect(controller.request.path_parameters[:controller]).to eq('sessions')
    expect(controller.controller_path).to eq('sessions')
  end
end
