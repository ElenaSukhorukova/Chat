# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'chatrooms/edit' do
  it 'infers the controller action' do
    expect(controller.request.path_parameters[:action]).to eq('edit')
  end
end
