class AccountingController < ActionController::Base
  include ApplicationHelper
  require 'xero-ruby'
  layout "application"

  def invoices
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @invoices = accounting_api.get_invoices(xero_tenant_id).invoices

  end

  def accounts
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @accounts = accounting_api.get_accounts(xero_tenant_id).accounts
  end

  def banktransactions
    opts = {
      if_modified_since: DateTime.parse('2020-02-06T12:17:43.202-08:00'), # DateTime | Only records created or modified since this timestamp will be returned
      where: 'Status==\"' + 'ACTIVE' + '\"', # String | Filter by an any element
      order: 'Type ASC', # String | Order by an any element
      page: 1, # Integer | Up to 100 bank transactions will be returned in a single API call with line items details
      unitdp: 4 # Integer | e.g. unitdp=4 – (Unit Decimal Places) You can opt in to use four decimal places for unit amounts
    }
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @bank_transactions = accounting_api.get_bank_transactions(xero_tenant_id)
  end

  def banktranfers
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @banktranfers = accounting_api.get_banktranfers(xero_tenant_id).banktranfers
  end

  def batchpayments
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @batchpayments = accounting_api.get_batch_payments(xero_tenant_id).batch_payments
  end

  def brandingthemes
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @brandingthemes = accounting_api.get_branding_themes(xero_tenant_id).branding_themes
  end

  def contacts
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @contacts = accounting_api.get_contacts(xero_tenant_id).contacts
  end

  def contactgroups
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @contactgroups = accounting_api.get_contact_groups(xero_tenant_id).contact_groups
  end

  def creditnotes
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @creditnotes = accounting_api.get_credit_notes(xero_tenant_id).credit_notes
  end

  def currencies
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @currencies = accounting_api.get_currencies(xero_tenant_id).currencies
  end

  def employees
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @employees = accounting_api.get_employees(xero_tenant_id).employees
  end

  def items
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @items = accounting_api.get_items(xero_tenant_id).items
  end

  def journals
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @journals = accounting_api.get_journals(xero_tenant_id).journals
  end

  def linked_transactions
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @linked_transactions = accounting_api.get_linked_transactions(xero_tenant_id).linked_transactions
  end

  def manualjournals
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @manual_journals = accounting_api.get_manual_journals(xero_tenant_id).manual_journals
  end

  def organisations
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @organisations = accounting_api.get_organisations(xero_tenant_id).organisations
  end

  def overpayments
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @overpayments = accounting_api.get_overpayments(xero_tenant_id).overpayments
  end

  def paymentservices
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @paymentservices = accounting_api.get_payment_services(xero_tenant_id).payment_services
  end

  def payments
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @payments = accounting_api.get_payments(xero_tenant_id).payments
  end

  def prepayments
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @prepayments = accounting_api.get_prepayments(xero_tenant_id).prepayments
  end

  def purchaseorders
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @purchaseorders = accounting_api.get_purchaseorders(xero_tenant_id).purchaseorders
  end

  def quotes
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @quotes = accounting_api.get_quotes(xero_tenant_id).quotes
  end

  def receipts
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @receipts = accounting_api.get_receipts(xero_tenant_id).receipts
  end

  def reports
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @reports = accounting_api.get_reports(xero_tenant_id).reports
  end

  def taxrates
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @taxrates = accounting_api.get_taxrates(xero_tenant_id).taxrates
  end

  def trackingcategories
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @trackingcategories = accounting_api.get_transactions(trackingcategories).trackingcategories
  end

  def users
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant
    @users = accounting_api.get_users(xero_tenant_id).users
  end

end
