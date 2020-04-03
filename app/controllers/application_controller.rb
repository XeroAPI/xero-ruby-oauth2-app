class ApplicationController < ActionController::Base
  require 'xero-ruby'

  def home

    # XeroRuby.configure do |config|
    #   # Configure OAuth2 access token for authorization: OAuth2
    #   config.access_token = TOKEN_SET['access_token']
    # end

    config = {
      client_id: "902DD32276574ED199639D9226A425B1",
      client_secret: 'PeNYDifbqi4Q3l9mG_kTg3LdLZ7RIUFpOOas-16sqkPV_e5C',
      redirect_uri: 'http://localhost:5000/callback'
    }
    xero_client = XeroRuby::ApiClient.new(config)
    @authorization_url = xero_client.authorization_url
  end

  def callback
    xero_client = XeroRuby::ApiClient.new
    @token_set = xero_client.get_token_set_from_callback(params)
  end
end
