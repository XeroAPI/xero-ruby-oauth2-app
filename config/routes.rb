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
  post '/refresh-token', to: 'application#refresh_token'
  post '/change_organisation', to: 'application#change_organisation'
  post '/disconnect', to: 'application#disconnect'

  # accounting routes
  get '/accounts', to: 'accounting#accounts'
  get '/accounts-filtered', to: 'accounting#accounts_filtered'  
  get '/accounts/create/attachment', to: 'accounting#create_account_attachment_by_file_name'

  get '/invoices', to: 'accounting#invoices'
  get '/invoices/recent', to: 'accounting#invoices_recent'
  get '/invoices/create', to: 'accounting#invoices_create'
  get '/invoices/pdf', to: 'accounting#get_invoice_as_pdf'
  get '/invoices/create/attachment', to: 'accounting#create_invoice_attachment_by_file_name'

  get '/banktransactions', to: 'accounting#banktransactions'
  get '/banktransactions/create', to: 'accounting#banktransactions_create'

  get '/banktransfers', to: 'accounting#banktransfers'

  get '/batchpayments', to: 'accounting#batchpayments'

  get '/brandingthemes', to: 'accounting#brandingthemes'

  get '/contacts', to: 'accounting#contacts'
  get '/contact-history', to: 'accounting#contact_history'

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
  get '/payments/create', to: 'accounting#payments_create'
  get '/payments-history', to: 'accounting#payment_history'

  get '/prepayments', to: 'accounting#prepayments'

  get '/purchaseorders', to: 'accounting#purchaseorders'

  get '/quotes', to: 'accounting#quotes'

  get '/receipts', to: 'accounting#receipts'

  get '/reports', to: 'accounting#reports'

  get '/taxrates', to: 'accounting#taxrates'

  get '/trackingcategories', to: 'accounting#trackingcategories'

  get '/users', to: 'accounting#users'

  # asset routes
  get '/assets', to: 'assets#assets'
  # project routes
  get '/projects', to: 'projects#projects'
end
