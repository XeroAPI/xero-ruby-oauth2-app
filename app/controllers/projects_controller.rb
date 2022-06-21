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

  def projects_tasks_get_all
     #Grab a Project Id
     project = xero_client.project_api.get_projects(current_user.active_tenant_id).items.first
     project_id = project.project_id

       opts = {
        page: 1
       }

     @projects = project
     @tasks = xero_client.project_api.get_tasks(current_user.active_tenant_id, project_id, opts)
     render :tasks
  end
  
  def projects_tasks_get_one
    #Grab a Project Id
    project = xero_client.project_api.get_projects(current_user.active_tenant_id).items.first
    project_id = project.project_id

    @projects = project
    #Grab a Task Id
    task = xero_client.project_api.get_tasks(current_user.active_tenant_id, project_id).items.first
    task_id = task.task_id 
 
    @tasks = xero_client.project_api.get_task(current_user.active_tenant_id, project_id, task_id)

    render :tasks
 end   

 def projects_tasks_create
   #Grab a Project Id
   project = xero_client.project_api.get_projects(current_user.active_tenant_id).items.first
   project_id = project.project_id
   @projects = project
   tasks = {
    name: "Chase initial deposit",
    rate: {
      currency: "GBP",
      value: 50.00
    },
    chargeType: "TIME",
    estimateMinutes: 120
  }

  @tasks = xero_client.project_api.create_task(current_user.active_tenant_id, project_id, tasks)
  render :tasks
 end

 def projects_tasks_update
  #Grab a Project Id
  project = xero_client.project_api.get_projects(current_user.active_tenant_id).items.first
  project_id = project.project_id
  @projects = project
  
  #Grab a Task Id
   task = xero_client.project_api.get_tasks(current_user.active_tenant_id, project_id).items.first
   task_id = task.task_id 

   task_update = {
    name: "Updated Task here",
    rate: {
      currency: "GBP",
      value: 750.00
    },
    chargeType: "FIXED"
  }

  @tasks = xero_client.project_api.update_task(current_user.active_tenant_id, project_id, task_id, task_update)
  render :tasks
end

def projects_tasks_delete
  #Grab a Project Id
  project = xero_client.project_api.get_projects(current_user.active_tenant_id).items.first
  project_id = project.project_id
  @projects = project
  
  #Grab a Task Id
   task = xero_client.project_api.get_tasks(current_user.active_tenant_id, project_id).items.first
   task_id = task.task_id 

  @tasks = xero_client.project_api.delete_task(current_user.active_tenant_id, project_id, task_id)
  render :tasks
end

def projects_time_get_all
  #Grab a Project Id
  project = xero_client.project_api.get_projects(current_user.active_tenant_id).items.first
  project_id = project.project_id
  @projects = project

  @times = xero_client.project_api.get_time_entries(current_user.active_tenant_id, project_id).items
  render :time_entries
end 

def projects_time_get_one
  #Grab a Project Id
  project = xero_client.project_api.get_projects(current_user.active_tenant_id).items.first
  project_id = project.project_id
  @projects = project

  times = xero_client.project_api.get_time_entries(current_user.active_tenant_id, project_id).items.first
  time_id = times.time_entry_id

  @times = xero_client.project_api.get_time_entry(current_user.active_tenant_id, project_id, time_id)
  render :time_entries
end 

def projects_time_create
  #Grab a Project Id
  project = xero_client.project_api.get_projects(current_user.active_tenant_id).items.first
  project_id = project.project_id
  @projects = project

  #Grab a Task Id
  task = xero_client.project_api.get_tasks(current_user.active_tenant_id, project_id).items.first
  task_id = task.task_id 

  #Grab a Project user
  user = xero_client.project_api.get_project_users(current_user.active_tenant_id).items
  @users = user
  user = xero_client.project_api.get_project_users(current_user.active_tenant_id).items.last
  user_id = user.user_id

  times = {
    userId: user_id,
    taskId: task_id,
    dateUtc: "2022-07-01T14:09:15Z",
    duration: 265,
    description: "Survey on site"
  }
  
  @times = xero_client.project_api.create_time_entry(current_user.active_tenant_id, project_id, times)
  
  render :time_entries
end 

def projects_time_update
  #Grab a Project Id
  project = xero_client.project_api.get_projects(current_user.active_tenant_id).items.first
  project_id = project.project_id
  @projects = project

  #Grab a Task Id
  task = xero_client.project_api.get_tasks(current_user.active_tenant_id, project_id).items.first
  task_id = task.task_id 

  #Grab a Project user
  user = xero_client.project_api.get_project_users(current_user.active_tenant_id).items
  @users = user
  user = xero_client.project_api.get_project_users(current_user.active_tenant_id).items.last
  user_id = user.user_id

  #Grab a Time Id
  times = xero_client.project_api.get_time_entries(current_user.active_tenant_id, project_id).items.first
  time_id = times.time_entry_id

  time_now = Time.now.strftime('%Y-%m-%dT%H:%M:%S.%L%z')
  time_update = {
    userId: user_id,
    taskId: task_id,
    dateUtc: time_now,
    duration: 360,
  }
  
  time = xero_client.project_api.update_time_entry(current_user.active_tenant_id, project_id, time_id, time_update)
  
  render :time_entries
  
end 

def projects_time_delete
  #Grab a Project Id
  project = xero_client.project_api.get_projects(current_user.active_tenant_id).items.first
  project_id = project.project_id
  @projects = project

  #Grab a Time Entry Id
  times = xero_client.project_api.get_time_entries(current_user.active_tenant_id, project_id).items.first
  time_id = times.time_entry_id

  time_delete = xero_client.project_api.delete_time_entry(current_user.active_tenant_id, project_id, time_id)

  render :time_entries
  
end  

end
