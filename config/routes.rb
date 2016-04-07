Rails.application.routes.draw do
  namespace :api, :path => "", :constraints => {:subdomain => "api"} do
    namespace :v1 do
      mount_devise_token_auth_for 'User', at: 'auth'

      get "time_entries/current" => "time_entries#current"
      post "time_entries/stop" => "time_entries#stop"
      resources :time_entries do
      end
      resources :projects
      resources :clients
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
