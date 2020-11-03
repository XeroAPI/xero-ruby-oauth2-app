class PayrollNzController < ActionController::Base
  include ApplicationHelper
  require 'xero-ruby'
  layout 'application'

  before_action :has_token_set?
  
  def employees
    @employees = xero_client.payroll_nz_api.get_employees(current_user.active_tenant_id).employees
  end
end