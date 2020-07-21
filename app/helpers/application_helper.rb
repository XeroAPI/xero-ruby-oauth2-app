module ApplicationHelper
  require 'jwt'

  def token_expired
    token_expiry = Time.at(access_token['exp'])
    exp_text = time_ago_in_words(token_expiry)
    token_expiry > Time.now ? "in #{exp_text}" : "#{exp_text} ago" 
  end

  def id_token
    JWT.decode(current_user.token_set['id_token'], nil, false)[0] if current_user && current_user.token_set
  end

  def access_token
    JWT.decode(current_user.token_set['access_token'], nil, false)[0] if current_user && current_user.token_set
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end


  def set_token_set_from_file(email)
    user = User.find_by_email(email)
    file_contents = File.read(Rails.root + 'app/data/token_set.json')
    token_set = JSON.parse(JSON.parse(file_contents))
    user.update!(token_set: token_set)
    user.update!(active_tenant_id: token_set['xero_tenant_id'])
  end
  
  # helper.set_token_set_from_file('chris.knight@xero.com')

  def xero_client
    creds = {
      client_id: ENV['CLIENT_ID'],
      client_secret: ENV['CLIENT_SECRET'],
      redirect_uri: ENV['REDIRECT_URI'],
      scopes: ENV['SCOPES']
    }
    @xero_client ||= XeroRuby::ApiClient.new(credentials: creds)

    return @xero_client
  end

  def has_token_set?
    unless current_user && current_user.token_set
      redirect_to authorization_url
      return
    end
  end

  def authorization_url
    @authorization_url ||= xero_client.authorization_url 
  end

  def latest_connection(connections)
    if connections.length
      connections.sort { |a,b|
        DateTime.parse(a['createdDateUtc']) <=> DateTime.parse(b['createdDateUtc'])
      }.first['tenantId']
    else
      nil
    end
  end
end
