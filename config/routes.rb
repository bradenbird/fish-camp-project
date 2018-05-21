FishCampProject::Application.routes.draw do
  resources :sessions, only: [:create, :destroy]

  resources :applicants do
    collection { post :import }

    collection { post :delete_all }
    collection { get 'delete/:uin', action: :delete }
    collection { get :edit }
    resources :interviews, except: :destroy
    resources :evaluations, except: :destroy
  end

  resources :users do
    collection { get :makeAdmin }
    collection { get :makeChair }
    collection { get :makeGuest }
  end

  get "/admin/index", to: "admin#index", as: "admin"
  get "/admin/:id", to: "admin#show"

  get "auth/:provider/callback", to: "sessions#create"
  get "auth/failure", to: redirect("/")
  get "signout", to: "sessions#destroy", as: "signout"

  get "/fc/home", to: redirect("/")
  get "/fc/denied", to: "fc#denied", as: "denied"
  get "/fc/login/", to: "fc#login", as: "login"
  get "/fc/register", to: "fc#register", as: "register"

  get "/fc/profile", to: "fc#profile", as: "profile"

  root to: "fc#home"
end
