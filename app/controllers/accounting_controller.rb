class AccountingController < ActionController::Base
  include ApplicationHelper
  require 'xero-ruby'
  layout 'application'

  before_action :has_token_set?

  # xero_client is setup in application_helper.rb
  
  def invoices
    @invoices = xero_client.accounting_api.get_invoices(current_user.active_tenant_id).invoices
    @invoice = xero_client.accounting_api.get_invoice(current_user.active_tenant_id, @invoices.first.invoice_id).invoices.first
  end

  def invoices_create
    contacts = xero_client.accounting_api.get_contacts(current_user.active_tenant_id).contacts
    invoices = { invoices: [{ type: XeroRuby::Accounting::Invoice::ACCREC, contact: { ContactId: contacts[0].contact_id }, LineItems: [{ Description: "Acme Tires Desc",  quantity: 32.0, unitAmount: BigDecimal("20.99"), account_code: "600", tax_type: XeroRuby::Accounting::TaxType::NONE }], date: "2019-03-11", due_date: "2018-12-10", reference: "Website Design", status: XeroRuby::Accounting::Invoice::DRAFT }]}
    @invoices = xero_client.accounting_api.create_invoices(current_user.active_tenant_id, invoices).invoices
  end

  def get_invoice_as_pdf
    invoice = xero_client.accounting_api.get_invoices(current_user.active_tenant_id).invoices.first
    invoice_pdf = xero_client.accounting_api.get_invoice_as_pdf(current_user.active_tenant_id, invoice.invoice_id)
    send_file invoice_pdf.path
  end

  def create_invoice_attachment_by_file_name
    @invoice = xero_client.accounting_api.get_invoices(current_user.active_tenant_id).invoices.first
    file_name = "an-invoice-filename.png"
    opts = {
      include_online: true # Boolean | Allows an attachment to be seen by the end customer within their online invoice
    }
    file = File.read(Rails.root.join('app/assets/images/xero-api.png'))
    @attachment = xero_client.accounting_api.create_invoice_attachment_by_file_name(current_user.active_tenant_id, @invoice.invoice_id, file_name, file, opts)
  end

  def accounts
    @accounts = xero_client.accounting_api.get_accounts(current_user.active_tenant_id).accounts
  end

  def create_account_attachment_by_file_name
    @account = xero_client.accounting_api.get_accounts(current_user.active_tenant_id).accounts.first
    file_name = "an-account-filename.png"
    opts = {
      include_online: true # Boolean | Allows an attachment to be seen by the end customer within their online invoice
    }
    file = File.read(Rails.root.join('app/assets/images/xero-api.png'))
    @attachment = xero_client.accounting_api.create_account_attachment_by_file_name(current_user.active_tenant_id, @account.account_id, file_name, file, opts)
  end

  def banktransactions
    opts = {
      if_modified_since: DateTime.parse('2020-02-06T12:17:43.202-08:00'), # DateTime | Only records created or modified since this timestamp will be returned
      where: 'Status==\"' + 'ACTIVE' + '\"', # String | Filter by an any element
      order: 'Type ASC', # String | Order by an any element
      page: 1, # Integer | Up to 100 bank transactions will be returned in a single API call with line items details
      unitdp: 4 # Integer | e.g. unitdp=4 – (Unit Decimal Places) You can opt in to use four decimal places for unit amounts
    }
    @bank_transactions = xero_client.accounting_api.get_bank_transactions(current_user.active_tenant_id).bank_transactions
  end

  def banktranfers
    opts = {
      if_modified_since: DateTime.parse('2020-02-06T12:17:43.202-08:00'), # DateTime | Only records created or modified since this timestamp will be returned
      where: 'Status==\"' + "Active" + '\"', # String | Filter by an any element
      order: 'Amount ASC' # String | Order by an any element
    }
    @banktranfers = xero_client.accounting_api.get_bank_transfer(current_user.active_tenant_id, '?' + opts.to_query).bank_transfers
  end

  def batchpayments
    @batchpayments = xero_client.accounting_api.get_batch_payments(current_user.active_tenant_id).batch_payments
  end

  def brandingthemes
    @brandingthemes = xero_client.accounting_api.get_branding_themes(current_user.active_tenant_id).branding_themes
  end

  def contacts
    @contacts = xero_client.accounting_api.get_contacts(current_user.active_tenant_id).contacts
  end
  
  def contact_history
    contacts = { contacts: [{ name: "Bruce Banner #{rand(10000)}", email_address: "hulk@avengers#{rand(10000)}.com", phones: [{ phone_type: XeroRuby::Accounting::Phone::MOBILE, phone_number: "555-1212", phone_area_code: "303" }], payment_Terms: { bills: { day: 15, type: XeroRuby::Accounting::PaymentTermType::OFCURRENTMONTH }, sales: { day: 10, type: XeroRuby::Accounting::PaymentTermType::DAYSAFTERBILLMONTH }}}]}
    @contact = xero_client.accounting_api.create_contacts(current_user.active_tenant_id, contacts).contacts.first
    puts "@contact#{@contact.inspect}"
    history_records = { history_records:[ { details: "This contact now has some History #{rand(10000)}" } ]}
    @contact_history = xero_client.accounting_api.create_contact_history(current_user.active_tenant_id, @contact.contact_id, history_records)
  end

  def contactgroups
    @contactgroups = xero_client.accounting_api.get_contact_groups(current_user.active_tenant_id).contact_groups
  end

  def creditnotes
    @creditnotes = xero_client.accounting_api.get_credit_notes(current_user.active_tenant_id).credit_notes
  end

  def currencies
    @currencies = xero_client.accounting_api.get_currencies(current_user.active_tenant_id).currencies
  end

  def employees
    @employees = xero_client.accounting_api.get_employees(current_user.active_tenant_id).employees
  end

  def items
    @items = xero_client.accounting_api.get_items(current_user.active_tenant_id).items
  end

  def journals
    @journals = xero_client.accounting_api.get_journals(current_user.active_tenant_id).journals
  end

  def linked_transactions
    @linked_transactions = xero_client.accounting_api.get_linked_transactions(current_user.active_tenant_id).linked_transactions
  end

  def manualjournals
    @manual_journals = xero_client.accounting_api.get_manual_journals(current_user.active_tenant_id).manual_journals
  end

  def organisations
    @organisations = xero_client.accounting_api.get_organisations(current_user.active_tenant_id).organisations
  end

  def overpayments
    @overpayments = xero_client.accounting_api.get_overpayments(current_user.active_tenant_id).overpayments
  end

  def payments
    @payments = xero_client.accounting_api.get_payments(current_user.active_tenant_id).payments
  end

  def payment_history
    payment = xero_client.accounting_api.get_payments(current_user.active_tenant_id).payments.first
    history_records = { history_records:[ { details: "This payment now has some History #{rand(10000)}" } ]}
    @payment_history = xero_client.accounting_api.create_payment_history(current_user.active_tenant_id, payment.payment_id, history_records)
  end

  def prepayments
    @prepayments = xero_client.accounting_api.get_prepayments(current_user.active_tenant_id).prepayments
  end

  def purchaseorders
    @purchaseorders = xero_client.accounting_api.get_purchase_orders(current_user.active_tenant_id).purchase_orders
  end

  def quotes
    @quotes = xero_client.accounting_api.get_quotes(current_user.active_tenant_id).quotes
  end

  def receipts
    @receipts = xero_client.accounting_api.get_receipts(current_user.active_tenant_id).receipts
  end

  def reports
    contact_id = xero_client.accounting_api.get_contacts(current_user.active_tenant_id).contacts[0].contact_id
    @reports = xero_client.accounting_api.get_report_aged_payables_by_contact(current_user.active_tenant_id, contact_id).reports
  end

  def taxrates
    @taxrates = xero_client.accounting_api.get_tax_rates(current_user.active_tenant_id).tax_rates
  end

  def trackingcategories
    @trackingcategories = xero_client.accounting_api.get_tracking_categories(current_user.active_tenant_id).tracking_categories
  end

  def users
    @users = xero_client.accounting_api.get_users(current_user.active_tenant_id).users
  end

end
