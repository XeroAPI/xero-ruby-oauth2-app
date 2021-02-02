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
  get '/auth/callback', to: 'application#callback'
  post '/refresh-token', to: 'application#refresh_token'
  post '/revoke-token', to: 'application#revoke_token'
  post '/change_organisation', to: 'application#change_organisation'
  post '/disconnect', to: 'application#disconnect'

  # accounting routes
  get '/accounts', to: 'accounting#accounts'
  get '/accounts_filtered', to: 'accounting#accounts_filtered'  
  get '/create_account_attachment_by_file_name', to: 'accounting#create_account_attachment_by_file_name'

  get '/invoices', to: 'accounting#invoices'
  get '/invoices_recent', to: 'accounting#invoices_recent'
  get '/invoices_create', to: 'accounting#invoices_create'
  get '/get_invoice_as_pdf', to: 'accounting#get_invoice_as_pdf'
  get '/accounting_invoice_create_attachment', to: 'accounting#create_invoice_attachment_by_file_name'

  get '/banktransactions', to: 'accounting#banktransactions'
  get '/banktransactions_create', to: 'accounting#banktransactions_create'

  get '/banktransfers', to: 'accounting#banktransfers'

  get '/batchpayments', to: 'accounting#batchpayments'
  get '/batchpayments_create', to: 'accounting#batchpayments_create'

  get '/brandingthemes', to: 'accounting#brandingthemes'

  get '/contacts', to: 'accounting#contacts'
  get '/contact_history', to: 'accounting#contact_history'

  get '/contactgroups', to: 'accounting#contactgroups'

  get '/creditnotes', to: 'accounting#creditnotes'

  get '/currencies', to: 'accounting#currencies'

  get '/employees', to: 'accounting#employees'

  get '/items', to: 'accounting#items'

  get '/journals', to: 'accounting#journals'

  get '/linked_transactions', to: 'accounting#linked_transactions'

  get '/manualjournals', to: 'accounting#manualjournals'

  get '/organisations', to: 'accounting#organisations'

  get '/overpayments', to: 'accounting#overpayments'

  get '/paymentservices', to: 'accounting#paymentservices'

  get '/payments', to: 'accounting#payments'
  get '/payments_create', to: 'accounting#payments_create'
  get '/payments_history', to: 'accounting#payment_history'

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

  # files routes
  get '/get_files', to: 'files#get_files'
  get '/get_file', to: 'files#get_file'
  get '/get_file_content', to: 'files#get_file_content'
  get '/upload_file', to: 'files#upload_file'
  get '/update_file', to: 'files#update_file'
  get '/delete_file', to: 'files#delete_file'

  get '/create_file_association', to: 'files#create_file_association'
  get '/delete_file_association', to: 'files#delete_file_association'
  get '/get_file_associations', to: 'files#get_file_associations'
  get '/get_associations_by_object', to: 'files#get_associations_by_object'

  get '/get_folder', to: 'files#get_folder'
  get '/get_folders', to: 'files#get_folders'
  get '/create_folder', to: 'files#create_folder'
  get '/update_folder', to: 'files#update_folder'
  get '/delete_folder', to: 'files#delete_folder'
  get '/get_inbox', to: 'files#get_inbox'

  # payroll routes
  get '/payroll/employees/au', to: 'payroll_au#employees'
  get '/payroll/timesheets/au', to: 'payroll_au#timesheets'
  get '/payroll/employees/nz', to: 'payroll_nz#employees'
  get '/payroll/employees/uk', to: 'payroll_uk#employees'
end
