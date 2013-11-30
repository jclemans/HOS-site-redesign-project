HouseOfSound::Application.routes.draw do
  resources :programs do 
    collection do 
      get :all
    end
  end

  resources :inquiries
  resources :dj_applications

  root 'home#index'
end
