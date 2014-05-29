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

  resources :schedules, only: [:index]
  resources :inquiries
  resources :dj_applications
  resources :users, only: [:show, :edit, :update]

  root 'home#index'
end
