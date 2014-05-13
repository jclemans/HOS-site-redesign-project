HouseOfSound::Application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :programs do 
    collection do 
      get :all
    end
  end

  resources :inquiries
  resources :dj_applications

  root 'home#index'
end
