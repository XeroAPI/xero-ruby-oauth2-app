class ApplicationController < ActionController::Base
  include ApplicationHelper
  require 'xero-ruby'

  helper_method :current_user
  before_action :xero_client

  def home
  end

  def callback
    @token_set = @xero_client.get_token_set_from_callback(params)
    # you can use `@xero_client.connections` to fetch info about which orgs
    # the user has authorized and the most recently connected tenant_id
    current_user.token_set = @token_set if !@token_set["error"]
    current_user.token_set['connections'] = @xero_client.connections
    current_user.active_tenant_id = latest_connection(current_user.token_set['connections'])
    current_user.save!
    flash.notice = "Successfully received Xero Token Set"
  end

  def refresh_token
    @token_set = @xero_client.refresh_token_set(current_user.token_set)
    current_user.token_set = @token_set if !@token_set["error"]
    current_user.token_set['connections'] = @xero_client.connections
    current_user.save!
    flash.notice = "Successfully Refreshed Token"
    redirect_to root_url
  end

  def revoke_token
    id = current_user.id
    @xero_client.revoke_token(current_user.token_set)
    current_user.token_set = nil
    current_user.save!
    flash.notice = "Successfully Revoked Token"
    redirect_to root_url
  end

  def change_organisation
    current_user.active_tenant_id = params['change_organisation']['active_tenant_id']
    current_user.save!
    flash.notice = "Current Tenant/Org updated <strong>#{current_user.active_tenant_id}</strong>"
    redirect_to root_url
  end

  def disconnect
    remaining_connections = @xero_client.disconnect(params[:connection_id])
    current_user.token_set['connections'] = remaining_connections
    current_user.active_tenant_id = latest_connection(current_user.token_set['connections'])
    current_user.save!
    flash.notice = "Removed <strong>#{current_user.active_tenant_id}</strong>"
    redirect_to root_url
  end
end
