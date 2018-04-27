FishCampProject::Application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get '/fc/applicants', to: 'applicants#index', as: 'applicants' 
  get '/fc/applicants/:uin', to: 'applicants#show'
  post '/fc/applicants/update/:uin', to: 'applicants#update'
  #get '/fc/applicants/delete/:uin', to: 'applicants#delete'
  

  resources :sessions, only: [:create, :destroy]

  resources :applicants do
    collection { post :import }

    collection { post :delete_all}
    collection { get 'delete/:uin', action: :delete }
    collection { get :edit}
    resources :interviews, except: :destroy
    resources :evaluations, except: :destroy
  end
  
  resources :users do
    collection { get :makeAdmin}
    collection { get :makeChair}
    collection { get :makeGuest}

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

  get "/admin/index", to: "admin#index", as: "admin"

  get "/admin/:id", to: "admin#show"
  
  get "/fc/denied", to: "fc#denied", as: "denied"

end
