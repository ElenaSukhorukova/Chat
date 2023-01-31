# frozen_string_literal: true

Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    root to: 'chatrooms#index'

    resource :session, only: %i[new create destroy]
    resources :users, except: %i[index destroy]

    namespace :user do
      resources :chatrooms, only: :index
    end

    shallow do
      resources :chatrooms, except: %i[index] do
        resources :messages, only: :create do
          member { post :like }
        end
        resource :chatrooms_users, only: %i[create destroy]
      end
    end
    resources :chatrooms, only: :index
  end
end
