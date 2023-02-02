# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |number| "email#{number}@email.com" }
    user_name { 'Walter' }
    password { '123Test123!+' }
  end
end
