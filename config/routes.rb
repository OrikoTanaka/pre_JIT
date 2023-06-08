Rails.application.routes.draw do
  root "homes#index"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  devise_for :users
end
