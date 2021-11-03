class FinancesController < ActionController::Base
    include ApplicationHelper
    require 'xero-ruby'
    layout 'application'
  
    before_action :has_token_set?
    
    def accounting_activity_usage
      @finance_response = xero_client.finance_api.get_accounting_activity_account_usage(current_user.active_tenant_id, { start_month: 11.months.ago.strftime('%Y-%m'), end_month: Date.today.strftime('%Y-%m') })
    end

    def accounting_activity_lock_history
      @finance_response = xero_client.finance_api.get_accounting_activity_lock_history(current_user.active_tenant_id, { end_date: 2.months.ago.strftime('%Y-%m-%d') })
    end

    def accounting_activity_report_history
      @finance_response = xero_client.finance_api.get_accounting_activity_report_history(current_user.active_tenant_id, { end_date: 2.months.ago.strftime('%Y-%m-%d') })
    end

    def accounting_activity_user_activities
      @finance_response = xero_client.finance_api.get_accounting_activity_user_activities(current_user.active_tenant_id, { data_month: 1.month.ago.strftime('%Y-%m') })
    end

    def cash_validation
      @finance_response = xero_client.finance_api.get_cash_validation(current_user.active_tenant_id)
    end

    def financial_statement_balance_sheet
      @finance_response = xero_client.finance_api.get_financial_statement_balance_sheet(current_user.active_tenant_id, { balance_date: 2.months.ago.strftime('%Y-%m-%d') })
    end

    def financial_statement_cashflow
      @finance_response = xero_client.finance_api.get_financial_statement_cashflow(current_user.active_tenant_id, { start_date: 12.months.ago.strftime('%Y-%m-%d'), end_date: 1.months.ago.strftime('%Y-%m-%d') })
    end

    def financial_statement_profit_and_loss
      @finance_response = xero_client.finance_api.get_financial_statement_profit_and_loss(current_user.active_tenant_id, { start_date: 12.months.ago.strftime('%Y-%m-%d'), end_date: 1.months.ago.strftime('%Y-%m-%d') })
    end

    def financial_statement_trial_balance
      @finance_response = xero_client.finance_api.get_financial_statement_trial_balance(current_user.active_tenant_id, { end_date: 2.months.ago.strftime('%Y-%m-%d') })
    end

    def financial_statement_contacts_expense
      @finance_response = xero_client.finance_api.get_financial_statement_contacts_expense(current_user.active_tenant_id)
    end

    def financial_statement_contacts_revenue
      @finance_response = xero_client.finance_api.get_financial_statement_contacts_revenue(current_user.active_tenant_id)
    end

    protected
    def default_render
      render 'finances/finances'
    end

  end
  