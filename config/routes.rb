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
  get '/refresh-token', to: 'application#refresh_token'
  get '/change_organisation', to: 'application#change_organisation'


  # accounting routes
  get '/accounts', to: 'accounting#accounts'
  get '/invoices', to: 'accounting#invoices'
  get '/banktransactions', to: 'accounting#banktransactions'
  get '/banktranfers', to: 'accounting#banktranfers'
  get '/batchpayments', to: 'accounting#batchpayments'
  get '/brandingthemes', to: 'accounting#brandingthemes'
  get '/contacts', to: 'accounting#contacts'
  get '/contactgroups', to: 'accounting#contactgroups'
  get '/creditnotes', to: 'accounting#creditnotes'
  get '/currencies', to: 'accounting#currencies'
  get '/employees', to: 'accounting#employees'
  get '/items', to: 'accounting#items'
  get '/journals', to: 'accounting#journals'
  get '/linked-transactions', to: 'accounting#linked_transactions'
  get '/manualjournals', to: 'accounting#manualjournals'
  get '/organisations', to: 'accounting#organisations'
  get '/overpayments', to: 'accounting#overpayments'
  get '/paymentservices', to: 'accounting#paymentservices'
  get '/payments', to: 'accounting#payments'
  get '/prepayments', to: 'accounting#prepayments'
  get '/purchaseorders', to: 'accounting#purchaseorders'
  get '/quotes', to: 'accounting#quotes'
  get '/receipts', to: 'accounting#receipts'
  get '/reports', to: 'accounting#reports'
  get '/taxrates', to: 'accounting#taxrates'
  get '/trackingcategories', to: 'accounting#trackingcategories'
  get '/users', to: 'accounting#users'
end
