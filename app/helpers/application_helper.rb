module ApplicationHelper
  require 'jwt'

  def decode_token_set(token_set)
    @id_token = JWT.decode(token_set['id_token'], nil, false)[0]
    @access_token = JWT.decode(token_set['access_token'], nil, false)[0]
  end
end
