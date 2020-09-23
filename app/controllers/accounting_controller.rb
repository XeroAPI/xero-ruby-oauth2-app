class AccountingController < ActionController::Base
  include ApplicationHelper
  require 'xero-ruby'
  layout 'application'

  before_action :has_token_set?

  # xero_client is setup in application_helper.rb
  
  def invoices
    get_one_opts = { 
      # statuses: [XeroRuby::Accounting::Invoice::AUTHORISED],
      where: {
        # type: ['==', XeroRuby::Accounting::Invoice::PAID],
        amount_due: ['>=', 0]
      },
      if_modified_since: (DateTime.now - 10.year).to_s
    }
    
    @invoice = xero_client.accounting_api.get_invoices(current_user.active_tenant_id, get_one_opts).invoices.first
    puts "@invoice: #{@invoice}"
    # Get all Contacts where:
    # 1) Is a Customer
    # 2) AND also Supplier
    contact_opts = {
      where: {
        is_customer: ['==', true],
        is_supplier: ['==', true],
      }
    }
    @contacts = xero_client.accounting_api.get_contacts(current_user.active_tenant_id, contact_opts).contacts
    # Get the Invoices where:
    # 1) Invoice Contact is one of those customers/suppliers
    get_all_opts = {
      contact_ids: [@contacts.map{|c| c.contact_id}]
    }
    @invoices = xero_client.accounting_api.get_invoices(current_user.active_tenant_id, get_all_opts).invoices
  end

  def invoices_recent
    # Get Invoices touched in the last hour
    opts = { 
      if_modified_since: (DateTime.now - 30.minute).to_s,
    }
    @invoices = xero_client.accounting_api.get_invoices(current_user.active_tenant_id, opts).invoices
    render :invoices_create
  end

  def invoices_create
    contacts = xero_client.accounting_api.get_contacts(current_user.active_tenant_id).contacts
    invoices = { invoices: [{ type: XeroRuby::Accounting::Invoice::ACCREC, contact: { ContactId: contacts.sample.contact_id }, LineItems: [{ Description: "Acme Tires Desc",  quantity: 32.0, unitAmount: BigDecimal("20.99"), account_code: "600", tax_type: XeroRuby::Accounting::TaxType::NONE }], date: "2019-03-11", due_date: "2018-12-10", reference: "Website Design", status: XeroRuby::Accounting::Invoice::DRAFT }]}
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
      if_modified_since: (DateTime.now - 6.month).to_s, # DateTime | Only records created or modified since this timestamp will be returned
      where: {
        type: ['==', XeroRuby::Accounting::BankTransaction::SPEND]
      },
      order: 'UpdatedDateUtc DESC', # String | Order by an any element
      page: 1, # Integer | Up to 100 bank transactions will be returned in a single API call with line items details
      unitdp: 4 # Integer | e.g. unitdp=4 – (Unit Decimal Places) You can opt in to use four decimal places for unit amounts
    }
    @bank_transactions = xero_client.accounting_api.get_bank_transactions(current_user.active_tenant_id, opts).bank_transactions
  end

  def banktransactions_create
    contacts = xero_client.accounting_api.get_contacts(current_user.active_tenant_id).contacts
    contact_id = contacts.first.contact_id
    bank_transactions = {
      bank_transactions: [
        { type: XeroRuby::Accounting::BankTransaction::SPEND, contact: { contact_id: contact_id }, line_items: [{ description: "This is the first", quantity: 1.0, unit_amount: 203.0, account_code: "600", tax_type: XeroRuby::Accounting::TaxType::NONE} ], bank_account: { code: "090" }},
        { type: XeroRuby::Accounting::BankTransaction::SPEND, contact: { contact_id: contact_id }, line_items: [{ description: "This is the second", quantity: 2.0, unit_amount: 180.0, account_code: "600", tax_type: XeroRuby::Accounting::TaxType::NONE} ], bank_account: { code: "090" }}
      ]
    }
    @bank_transactions = xero_client.accounting_api.create_bank_transactions(current_user.active_tenant_id, bank_transactions).bank_transactions
  end

  def banktransfers
    opts = {
      if_modified_since: (DateTime.now - 10.year).to_s, # DateTime | Only records created or modified since this timestamp will be returned
      where: {
        amount: [">=" , 999.99]
      },
      order: 'Amount ASC' # String | Order by an any element
    }
    @banktransfers = xero_client.accounting_api.get_bank_transfers(current_user.active_tenant_id, opts).bank_transfers
  end

  def batchpayments
    @batchpayments = xero_client.accounting_api.get_batch_payments(current_user.active_tenant_id).batch_payments
  end

  def brandingthemes
    @brandingthemes = xero_client.accounting_api.get_branding_themes(current_user.active_tenant_id).branding_themes
  end

  def contacts
    opts = {
      if_modified_since: (DateTime.now - 10.year).to_s,
      order: 'UpdatedDateUtc DESC',
      page: 1
    }
    @contacts = xero_client.accounting_api.get_contacts(current_user.active_tenant_id, opts).contacts
  end
  
  def contact_history
    contacts = { contacts: [{ name: "Bruce Banner #{rand(10000)}", email_address: "hulk@avengers#{rand(10000)}.com", phones: [{ phone_type: XeroRuby::Accounting::Phone::MOBILE, phone_number: "555-1212", phone_area_code: "303" }], payment_Terms: { bills: { day: 15, type: XeroRuby::Accounting::PaymentTermType::OFCURRENTMONTH }, sales: { day: 10, type: XeroRuby::Accounting::PaymentTermType::DAYSAFTERBILLMONTH }}}]}
    @contact = xero_client.accounting_api.create_contacts(current_user.active_tenant_id, contacts).contacts.first
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
  
  def payments_create
    # first find a contact, and create an invoice
    contact = xero_client.accounting_api.get_contacts(current_user.active_tenant_id).contacts.sample
    invoices = { invoices: [{ type: XeroRuby::Accounting::Invoice::ACCREC, contact: { contact_id: contact.contact_id }, line_items: [{ Description: "Acme Tires Desc",  quantity: 32.0, unit_amount: BigDecimal("20.99"), account_code: "600", tax_type: XeroRuby::Accounting::TaxType::NONE }], date: "2019-03-11", due_date: "2018-12-10", reference: "Website Design", status: XeroRuby::Accounting::Invoice::AUTHORISED }]}
    @invoice = xero_client.accounting_api.create_invoices(current_user.active_tenant_id, invoices).invoices.first

    # then build two payments and create them
    @account = xero_client.accounting_api.get_accounts(current_user.active_tenant_id).accounts[0]
    payments = {
      payments: [
        {
          invoice: { InvoiceId: @invoice.invoice_id },
          account: { AccountId: @account.account_id },
          date: DateTime.now,
          amount: (@invoice.amount_due / BigDecimal("2.0")).ceil(2)
        },
        {
          invoice: { InvoiceId: @invoice.invoice_id },
          account: { AccountId: @account.account_id },
          date: DateTime.now,
          amount: (@invoice.amount_due / BigDecimal("2.0")).floor(2)
        }
      ]
    }

    @payments = xero_client.accounting_api.create_payments(current_user.active_tenant_id, payments).payments
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
    opts = {
      status: XeroRuby::Accounting::PurchaseOrder::AUTHORISED,
      if_modified_since: (DateTime.now - 3.year).to_s,
      order: 'DeliveryDate'
    }
    @purchaseorders = xero_client.accounting_api.get_purchase_orders(current_user.active_tenant_id, opts).purchase_orders
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
