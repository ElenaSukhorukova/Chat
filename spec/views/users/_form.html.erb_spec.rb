# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'users/_form' do
  it 'includes a link to new' do
    expect(controller.request.path_parameters[:action]).to be_nil
  end
end
