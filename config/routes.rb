HouseOfSound::Application.routes.draw do
  devise_for :users

  ActiveAdmin.routes(self)
  resources :programs do
    collection do
      get :all
    end
  end

  resources :inquiries
  resources :dj_applications
  resources :users, only: [:show, :edit, :update]

  root 'home#index'
end
