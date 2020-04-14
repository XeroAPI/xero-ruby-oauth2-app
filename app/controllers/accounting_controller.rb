class AccountingController < ActionController::Base
  include ApplicationHelper
  require 'xero-ruby'
  layout 'application'
  
  def invoices
    @invoices = accounting_api.get_invoices(current_user.active_tenant_id).invoices

  end

  def accounts
    @accounts = accounting_api.get_accounts(current_user.active_tenant_id).accounts
  end

  def banktransactions
    opts = {
      if_modified_since: DateTime.parse('2020-02-06T12:17:43.202-08:00'), # DateTime | Only records created or modified since this timestamp will be returned
      where: 'Status==\"' + 'ACTIVE' + '\"', # String | Filter by an any element
      order: 'Type ASC', # String | Order by an any element
      page: 1, # Integer | Up to 100 bank transactions will be returned in a single API call with line items details
      unitdp: 4 # Integer | e.g. unitdp=4 – (Unit Decimal Places) You can opt in to use four decimal places for unit amounts
    }
    @bank_transactions = accounting_api.get_bank_transactions(current_user.active_tenant_id).bank_transactions
  end

  def banktranfers
    opts = {
      if_modified_since: DateTime.parse('2020-02-06T12:17:43.202-08:00'), # DateTime | Only records created or modified since this timestamp will be returned
      where: 'Status==\"' + "Active" + '\"', # String | Filter by an any element
      order: 'Amount ASC' # String | Order by an any element
    }
    @banktranfers = accounting_api.get_bank_transfer(current_user.active_tenant_id, '?' + opts.to_query).bank_transfers
  end

  def batchpayments
    @batchpayments = accounting_api.get_batch_payments(current_user.active_tenant_id).batch_payments
  end

  def brandingthemes
    @brandingthemes = accounting_api.get_branding_themes(current_user.active_tenant_id).branding_themes
  end

  def contacts
    @contacts = accounting_api.get_contacts(current_user.active_tenant_id).contacts
  end

  def contactgroups
    @contactgroups = accounting_api.get_contact_groups(current_user.active_tenant_id).contact_groups
  end

  def creditnotes
    @creditnotes = accounting_api.get_credit_notes(current_user.active_tenant_id).credit_notes
  end

  def currencies
    @currencies = accounting_api.get_currencies(current_user.active_tenant_id).currencies
  end

  def employees
    @employees = accounting_api.get_employees(current_user.active_tenant_id).employees
  end

  def items
    @items = accounting_api.get_items(current_user.active_tenant_id).items
  end

  def journals
    @journals = accounting_api.get_journals(current_user.active_tenant_id).journals
  end

  def linked_transactions
    @linked_transactions = accounting_api.get_linked_transactions(current_user.active_tenant_id).linked_transactions
  end

  def manualjournals
    @manual_journals = accounting_api.get_manual_journals(current_user.active_tenant_id).manual_journals
  end

  def organisations
    @organisations = accounting_api.get_organisations(current_user.active_tenant_id).organisations
  end

  def overpayments
    @overpayments = accounting_api.get_overpayments(current_user.active_tenant_id).overpayments
  end

  def payments
    @payments = accounting_api.get_payments(current_user.active_tenant_id).payments
  end

  def prepayments
    @prepayments = accounting_api.get_prepayments(current_user.active_tenant_id).prepayments
  end

  def purchaseorders
    @purchaseorders = accounting_api.get_purchase_orders(current_user.active_tenant_id).purchase_orders
  end

  def quotes
    @quotes = accounting_api.get_quotes(current_user.active_tenant_id).quotes
  end

  def receipts
    @receipts = accounting_api.get_receipts(current_user.active_tenant_id).receipts
  end

  def reports
    contact_id = accounting_api.get_contacts(current_user.active_tenant_id).contacts[0].contact_id
    @reports = accounting_api.get_report_aged_payables_by_contact(current_user.active_tenant_id, contact_id).reports
  end

  def taxrates
    @taxrates = accounting_api.get_tax_rates(current_user.active_tenant_id).tax_rates
  end

  def trackingcategories
    @trackingcategories = accounting_api.get_tracking_categories(current_user.active_tenant_id).tracking_categories
  end

  def users
    @users = accounting_api.get_users(current_user.active_tenant_id).users
  end

end
