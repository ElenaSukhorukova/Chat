Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    root 'chatroom#index'
    
    resources :users, only: %i[new create edit update], shallow: true do 
      resources :messages, only: %i[create]
    end

    resource :session, only: %i[new create destroy]
  end
end
