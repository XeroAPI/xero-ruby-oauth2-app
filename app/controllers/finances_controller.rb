class FinancesController < ActionController::Base
    include ApplicationHelper
    require 'xero-ruby'
    layout 'application'
  
    before_action :has_token_set?
    
    def accounting_activity_usage
      @finance_response = xero_client.finance_api.get_accounting_activity_account_usage(current_user.active_tenant_id, { startMonth: 3.years.ago, endMonth: Date.today}).account_usage
      render 'finances/finances'
    end

    def accounting_activity_lock_history
      @finance_response = xero_client.finance_api.get_accounting_activity_lock_history(current_user.active_tenant_id)
      render 'finances/finances'
    end

    def accounting_activity_report_history
      @finance_response = xero_client.finance_api.get_accounting_activity_report_history(current_user.active_tenant_id).reports
      render 'finances/finances'
    end

    def accounting_activity_user_activities
        @finance_response = xero_client.finance_api.get_accounting_activity_user_activities(current_user.active_tenant_id)
        render 'finances/finances'
    end

    def cash_validation
        @finance_response = xero_client.finance_api.get_cash_validation(current_user.active_tenant_id)
        render 'finances/finances'
    end

    def financial_statement_balance_sheet
      @finance_response = xero_client.finance_api.get_financial_statement_balance_sheet(current_user.active_tenant_id)
      render 'finances/finances'
    end

    def financial_statement_cashflow
        @financial_response = xero_client.finance_api.get_financial_statement_cashflow(current_user.active_tenant_id)
        render 'finances/finances'
    end

    def financial_statement_profit_and_loss
        @financial_response = xero_client.finance_api.get_financial_statement_profit_and_loss(current_user.active_tenant_id)
        render 'finances/finances'
    end

    def financial_statement_trial_balance
        @financial_response = xero_client.finance_api.get_financial_statement_trial_balance(current_user.active_tenant_id)
        render 'finances/finances'
    end





  end
  