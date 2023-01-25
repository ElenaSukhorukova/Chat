Rails.application.routes.draw do
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do
    root 'chatroom#index'
    get 'login', to: 'session#new'
  end
end
