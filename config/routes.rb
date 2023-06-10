Rails.application.routes.draw do

  # authenticated do
  #   root to: 'users#show', as: :authenticated_root
  # end

  root "homes#index"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  devise_for :users

  get 'users/dash_boards', to: 'users#show', as: :dash_boards
  resources :users
end
