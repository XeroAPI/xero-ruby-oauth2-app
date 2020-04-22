class AccountingController < ActionController::Base
  include ApplicationHelper
  require 'xero-ruby'
  layout 'application'
  
  def invoices
    @invoices = xero_client.accounting_client.get_invoices(current_user.active_tenant_id).invoices
  end

  def accounts
    @accounts = xero_client.accounting_client.get_accounts(current_user.active_tenant_id).accounts
  end

  def banktransactions
    opts = {
      if_modified_since: DateTime.parse('2020-02-06T12:17:43.202-08:00'), # DateTime | Only records created or modified since this timestamp will be returned
      where: 'Status==\"' + 'ACTIVE' + '\"', # String | Filter by an any element
      order: 'Type ASC', # String | Order by an any element
      page: 1, # Integer | Up to 100 bank transactions will be returned in a single API call with line items details
      unitdp: 4 # Integer | e.g. unitdp=4 – (Unit Decimal Places) You can opt in to use four decimal places for unit amounts
    }
    @bank_transactions = xero_client.accounting_client.get_bank_transactions(current_user.active_tenant_id).bank_transactions
  end

  def banktranfers
    opts = {
      if_modified_since: DateTime.parse('2020-02-06T12:17:43.202-08:00'), # DateTime | Only records created or modified since this timestamp will be returned
      where: 'Status==\"' + "Active" + '\"', # String | Filter by an any element
      order: 'Amount ASC' # String | Order by an any element
    }
    @banktranfers = xero_client.accounting_client.get_bank_transfer(current_user.active_tenant_id, '?' + opts.to_query).bank_transfers
  end

  def batchpayments
    @batchpayments = xero_client.accounting_client.get_batch_payments(current_user.active_tenant_id).batch_payments
  end

  def brandingthemes
    @brandingthemes = xero_client.accounting_client.get_branding_themes(current_user.active_tenant_id).branding_themes
  end

  def contacts
    @contacts = xero_client.accounting_client.get_contacts(current_user.active_tenant_id).contacts
  end

  def contactgroups
    @contactgroups = xero_client.accounting_client.get_contact_groups(current_user.active_tenant_id).contact_groups
  end

  def creditnotes
    @creditnotes = xero_client.accounting_client.get_credit_notes(current_user.active_tenant_id).credit_notes
  end

  def currencies
    @currencies = xero_client.accounting_client.get_currencies(current_user.active_tenant_id).currencies
  end

  def employees
    @employees = xero_client.accounting_client.get_employees(current_user.active_tenant_id).employees
  end

  def items
    @items = xero_client.accounting_client.get_items(current_user.active_tenant_id).items
  end

  def journals
    @journals = xero_client.accounting_client.get_journals(current_user.active_tenant_id).journals
  end

  def linked_transactions
    @linked_transactions = xero_client.accounting_client.get_linked_transactions(current_user.active_tenant_id).linked_transactions
  end

  def manualjournals
    @manual_journals = xero_client.accounting_client.get_manual_journals(current_user.active_tenant_id).manual_journals
  end

  def organisations
    @organisations = xero_client.accounting_client.get_organisations(current_user.active_tenant_id).organisations
  end

  def overpayments
    @overpayments = xero_client.accounting_client.get_overpayments(current_user.active_tenant_id).overpayments
  end

  def payments
    @payments = xero_client.accounting_client.get_payments(current_user.active_tenant_id).payments
  end

  def prepayments
    @prepayments = xero_client.accounting_client.get_prepayments(current_user.active_tenant_id).prepayments
  end

  def purchaseorders
    @purchaseorders = xero_client.accounting_client.get_purchase_orders(current_user.active_tenant_id).purchase_orders
  end

  def quotes
    @quotes = xero_client.accounting_client.get_quotes(current_user.active_tenant_id).quotes
  end

  def receipts
    @receipts = xero_client.accounting_client.get_receipts(current_user.active_tenant_id).receipts
  end

  def reports
    contact_id = xero_client.accounting_client.get_contacts(current_user.active_tenant_id).contacts[0].contact_id
    @reports = xero_client.accounting_client.get_report_aged_payables_by_contact(current_user.active_tenant_id, contact_id).reports
  end

  def taxrates
    @taxrates = xero_client.accounting_client.get_tax_rates(current_user.active_tenant_id).tax_rates
  end

  def trackingcategories
    @trackingcategories = xero_client.accounting_client.get_tracking_categories(current_user.active_tenant_id).tracking_categories
  end

  def users
    @users = xero_client.accounting_client.get_users(current_user.active_tenant_id).users
  end

end
