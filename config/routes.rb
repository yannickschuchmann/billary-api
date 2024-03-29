Rails.application.routes.draw do
  namespace :api, :path => "", :constraints => {:subdomain => "api"} do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'

      get "users/current" => "users#current"
      get "time_entries/current" => "time_entries#current"
      post "time_entries/stop" => "time_entries#stop"
      get "invoices/generate" => "invoices#generate"

      resources :time_entries
      resources :projects
      resources :clients
      resources :companies
      resources :invoices
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
