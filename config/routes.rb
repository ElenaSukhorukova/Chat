Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    root 'chatrooms#index'
    
    resources :users, only: %i[new create edit update], shallow: true do 
      resources :messages, only: %i[create]
      resources :chatrooms
    end

    resource :session, only: %i[new create destroy]

    mount ActionCable.server, at: '/cable'

  end
end
