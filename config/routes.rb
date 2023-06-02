Rails.application.routes.draw do
  root "homes#index"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  devise_for :users, controllers: {
    # UserのSessionsControllerには、Users::SessionsControllerを利用する。他のコントローラーも同じように修正する。
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
  }
end
