class ApplicationController < ActionController::Base
  require 'xero-ruby'
  require 'jwt'

  before_action :setup_client

  def setup_client
    config = {
      client_id: "902DD32276574ED199639D9226A425B1",
      client_secret: 'PeNYDifbqi4Q3l9mG_kTg3LdLZ7RIUFpOOas-16sqkPV_e5C',
      redirect_uri: 'http://localhost:5000/callback'
    }
    puts "HIIIIIIII"
    @xero_client ||= XeroRuby::ApiClient.new(config)
  end

  def home
    @authorization_url = @xero_client.authorization_url
  end

  def callback
    @token_set = @xero_client.get_token_set_from_callback(params)
    # You want to save the whole token_set
    # it contains some other important info besides the access_token
    @access_token = JWT.decode(@token_set['access_token'], nil, false)
    @id_token = JWT.decode(@token_set['id_token'], nil, false)
  end
end
