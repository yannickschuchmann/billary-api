Rails.application.routes.draw do
  get "time_entries/current" => "time_entries#current"
  post "time_entries/stop" => "time_entries#stop"
  resources :time_entries do
  end
  resources :projects

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # Serve websocket cable requests in-process
  # mount ActionCable.server => '/cable'
end
