HouseOfSound::Application.routes.draw do
  resources :programs do 
    collection do 
      get :all
    end
  end
  root 'home#index'
end
