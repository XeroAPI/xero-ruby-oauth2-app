class WebhooksController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def webhook
    key = ENV['WEBHOOK_KEY']
    payload = request.body.read
    calculated_hmac = Base64.encode64(OpenSSL::HMAC.digest('sha256', key, payload))
    puts calculated_hmac.strip()
    puts request.headers['x-xero-signature']
    if calculated_hmac.strip() == request.headers['x-xero-signature']
      render json: {}, status: :ok
    else
      render json: {}, status: :unauthorized
    end
  end
end
