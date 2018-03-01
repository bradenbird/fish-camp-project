Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # You can have the root of your site routed with "root"
  root 'fc#home'

  resources :fc, :path => '', :only => [:show, :new, :create, :index]

  get "/fc/home", to: "fc#home", as: "home"

  get "/fc/register", to: "fc#register", as: "register"

  get "/fc/profile", to: "fc#profile", as: "profile"

end
