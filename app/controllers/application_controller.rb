class ApplicationController < ActionController::Base
  include ApplicationHelper
  require 'xero-ruby'  

  helper_method :current_user
  before_action :xero_client

  def home
    decode_token_set(current_user.token_set)
  end

  def callback
    @token_set = @xero_client.get_token_set_from_callback(params)
    current_user.token_set = @token_set if !@token_set["error"]
    current_user.save!
    flash.now.notice = "Successfully received Xero Token Set"
  end

  def refresh_token
    @token_set = @xero_client.refresh_token_set(current_user.token_set)
    current_user.token_set = @token_set if !@token_set["error"]
    current_user.save!
    decode_token_set(current_user.token_set)
    render 'home', notice: 'Token Refreshed'
  end
end
