class FilesController < ActionController::Base
  include ApplicationHelper
  require 'xero-ruby'
  layout 'application'

  before_action :has_token_set?
  
  def get_files
    @get_files = xero_client.files_api.get_files(current_user.active_tenant_id)
    @files = xero_client.files_api.get_files(current_user.active_tenant_id).items
  end

  def get_file
    file_id = get_files.sample.id
    @file = xero_client.files_api.get_file(current_user.active_tenant_id, file_id)
  end

  def get_file_content
    file = get_files.sample
    temp_file = xero_client.files_api.get_file_content(current_user.active_tenant_id, file.id)
    send_file(
      temp_file.path,
      filename: file.name,
      type: file.mime_type
    )
  end

  def upload_file
    @folder = xero_client.files_api.get_folders(current_user.active_tenant_id).first
    file_name = "xero-api.png"
    file = File.new(Rails.root.join('app/assets/images/xero-api.png'))
    opts = {
      folder_id: @folder.id,
      body: file,
      name: file_name,
      filename: file_name,
      mime_type: 'image/png'
    }
    @file = xero_client.files_api.upload_file(current_user.active_tenant_id, opts)
  end

  def update_file
    file = get_files.sample
    opts = {
      file_object: {
        name: file.name + ' Updated'
      }
    }
    @file = xero_client.files_api.update_file(current_user.active_tenant_id, file.id, opts)
  end

  def delete_file
    @file = upload_file
    xero_client.files_api.delete_file(current_user.active_tenant_id, @file.id)
  end

  def get_file_associations
    file = get_files.last
    @file_associations = xero_client.files_api.get_file_associations(current_user.active_tenant_id, file.id)
  end

  def get_associations_by_object
    @object = xero_client.accounting_api.get_invoices(current_user.active_tenant_id).invoices.first
    @file_associations = xero_client.files_api.get_associations_by_object(current_user.active_tenant_id, "22b3fab4-ef56-4d70-a110-a7cc3c1a26cd")
  end

  def create_file_association
    @file = xero_client.files_api.get_files(current_user.active_tenant_id).items.first
    @invoice = xero_client.accounting_api.get_invoices(current_user.active_tenant_id).invoices.first
    opts = {
      association: {
        object_id: @invoice.invoice_id,
        object_group: "Invoice"
      }
     }
    @create_file_association = xero_client.files_api.create_file_association(current_user.active_tenant_id, @file.id, opts)
  end

  def delete_file_association
    @association = create_file_association
    xero_client.files_api.delete_file_association(current_user.active_tenant_id, @association.file_id, @association.object_id)
  end
  
  def get_folders
    @folders = xero_client.files_api.get_folders(current_user.active_tenant_id)
  end

  def get_folder
    folder = get_folders.first
    @folder = xero_client.files_api.get_folder(current_user.active_tenant_id, folder.id)
  end

  def create_folder
    opts = {
      folder: {
        name: "New folder who dis"
      }
    }
    @folder = xero_client.files_api.create_folder(current_user.active_tenant_id, opts)
  end

  def update_folder
    folder = create_folder
    folder_updates = {
      name: folder.name + ' (updated)'
    }
    @folder = xero_client.files_api.update_folder(current_user.active_tenant_id, folder.id, folder_updates)
  end

  def delete_folder
    folder = create_folder
    @delete_folder = xero_client.files_api.delete_folder(current_user.active_tenant_id, folder.id)
  end

  def get_inbox
    @inbox = xero_client.files_api.get_inbox(current_user.active_tenant_id)
  end
end
