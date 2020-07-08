class ProjectsController < ActionController::Base
  include ApplicationHelper
  require 'xero-ruby'
  layout 'application'

  before_action :has_token_set?
  
  def projects
    @projects = xero_client.project_api.get_projects(current_user.active_tenant_id).items
  end
end
