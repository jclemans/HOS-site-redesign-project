HouseOfSound::Application.routes.draw do
  resources :programs
  root 'home#index'
end
