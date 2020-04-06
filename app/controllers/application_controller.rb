class ApplicationController < ActionController::Base
  include ApplicationHelper
  require 'xero-ruby'  

  helper_method :current_user
  before_action :setup_client

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def setup_client
    creds = {
      client_id: "902DD32276574ED199639D9226A425B1",
      client_secret: 'PeNYDifbqi4Q3l9mG_kTg3LdLZ7RIUFpOOas-16sqkPV_e5C',
      redirect_uri: 'http://localhost:5000/callback',
      scopes: "openid profile email accounting.settings accounting.reports.read accounting.journals.read accounting.contacts accounting.attachments accounting.transactions assets assets.read projects projects.read offline_access"
    }
    @xero_client ||= XeroRuby::ApiClient.new(credentials: creds)
    @authorization_url = @xero_client.authorization_url
  end

  def home
    decode_token_set(current_user.token_set)
  end

  def callback
    @token_set = @xero_client.get_token_set_from_callback(params)
    current_user.token_set = @token_set if !@token_set["error"]
    current_user.save!
    flash.now.notice = "Successfully received Xero Token Set"
  end

  # def decode_token_set(client)
  #   @id_token = JWT.decode(client.token_set['id_token'], nil, false) if client.token_set && client.token_set['id_token']
  #   @access_token = JWT.decode(client.token_set['access_token'], nil, false) if client.token_set && client.token_set['access_token']
  # end
end
