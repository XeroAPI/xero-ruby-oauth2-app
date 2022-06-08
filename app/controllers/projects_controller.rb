class ProjectsController < ActionController::Base
  include ApplicationHelper
  require 'xero-ruby'
  layout 'application'

  before_action :has_token_set?
  
  def projects
    @projects = xero_client.project_api.get_projects(current_user.active_tenant_id).items
  end

  def projects_one
    # Get first project in the list
       @projects = xero_client.project_api.get_projects(current_user.active_tenant_id).items.first
    render :projects
  end

  def projects_create
    #create a new project
    
    #First grab a contact 
    contacts = xero_client.accounting_api.get_contacts(current_user.active_tenant_id).contacts

    projects = {    
        contact_id: contacts.sample.contact_id,
        name: "New Remodel Conservatory",
        estimate_amount: 5400,
        deadline_utc: "2022-10-23T18:25:43.511Z"      
    }

    @projects = xero_client.project_api.create_project(current_user.active_tenant_id, projects)
    render :projects
  end

  def projects_patch
    #First grab a Project Id to patch the new status
    project = xero_client.project_api.get_projects(current_user.active_tenant_id).items.first
    project_id = project.project_id  

    project_patch = {
      "status": "CLOSED" #  CLOSED or INPROGRESS
    }

    @projects = xero_client.project_api.patch_project(current_user.active_tenant_id, project_id, project_patch)
    render :projects
  end  

  def projects_update 
     #First grab a Project Id to update where Status is equal to In Progress
      opts = { 
        where: {
        states: "== INPROGRESS"
      }
      }
      
    project = xero_client.project_api.get_projects(current_user.active_tenant_id, opts).items.first
    project_id = project.project_id  

    project_update = {
        name: "Build Double Barn Garage with Extra Loft",
        estimate_amount: 7000,
        deadline_utc: "2023-04-01T10:00:00.511Z" 
    }

    @projects = xero_client.project_api.update_project(current_user.active_tenant_id, project_id, project_update)
    render :projects
  end   
end
