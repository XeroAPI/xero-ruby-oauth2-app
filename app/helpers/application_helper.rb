module ApplicationHelper
  require 'jwt'

  def decode_token_set(token_set)
    if token_set
      @id_token = JWT.decode(token_set['id_token'], nil, false)[0]
      @access_token = JWT.decode(token_set['access_token'], nil, false)[0]
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def xero_client
    creds = {
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET'],
      redirect_uri: ENV['REDIRECT_URI'],
      scopes: ENV['SCOPES']
    }
    @xero_client ||= XeroRuby::ApiClient.new(credentials: creds)
  end

  def accounting_api
    # used to ensure the access_token is being set on the current client
    xero_client.set_token_set(current_user.token_set)

    accounting_api = XeroRuby::AccountingApi.new(xero_client)
  end

  def authorization_url
    @authorization_url = @xero_client.authorization_url 
  end
end
