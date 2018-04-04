FishCampProject::Application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get '/fc/applicants', to: 'applicants#index', as: 'applicants' 


  resources :sessions, only: [:create, :destroy]

  resources :applicants do
    collection { post :import }
  end
  #root to: "home#show"
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # You can have the root of your site routed with "root"
  root 'fc#home'



  resources :fc, :path => '', :only => [:show, :new, :create, :index]

  get "/fc/home", to: "fc#home", as: "home"

  get "/fc/login/", to: "fc#login", as: "login"

  get "/fc/register", to: "fc#register", as: "register"

  get "/fc/profile", to: "fc#profile", as: "profile"

  get "/fc/denied", to: "fc#denied", as: "denied"

  get "/fc/interview", to: "fc#interview", as:"interview"



end
