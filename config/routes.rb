Rails.application.routes.draw do
  root 'home#index'

  devise_for :users,
    format: false,
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations',
      omniauth_callbacks: 'users/omniauth_callbacks'
    }
end
