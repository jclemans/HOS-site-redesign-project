HouseOfSound::Application.routes.draw do
  devise_for :users

  ActiveAdmin.routes(self)
  resources :programs, only: [:index, :show, :edit, :update] do
    resources :schedules do
      collection do
        get :all
      end
    end
  end

  resources :inquiries
  resources :dj_applications
  resources :users, only: [:show, :edit, :update]
  resources :episodes
  resources :tracks

  root 'home#index'
  get '/listen_live', to: 'home#listen_live'
end
