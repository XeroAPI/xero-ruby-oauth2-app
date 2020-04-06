Rails.application.routes.draw do
  root to: "application#home"

  # user routes
  get 'users/new' => 'users#new', as: :new_user
  post 'users' => 'users#create'

  # session routes
  get '/login'     => 'sessions#new'
	post '/login'    => 'sessions#create'
	delete '/logout' => 'sessions#destroy'  
  
  ## Xero 

  # authentication routes
  get '/callback', to: 'application#callback'

  # accounting routes
  get '/invoices', to: 'accounting#invoices'
end
