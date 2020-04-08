# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


# if your client is being created after you already have
    # a valid access_token, you can initialize it without `config:` or `credentials:`
    # and simply set the token set on the client
    client ||= XeroRuby::ApiClient.new()
    # this sets the access_token on the current client
    client.set_token_set(current_user.token_set)

    accounting_api = XeroRuby::AccountingApi.new(xero_client)



    1) chris.knight@ ~/code/sdks/xeroapi-sdk-codegen/scripts (xero_ruby_oauth2_flow_and_faraday) $ ./ruby.sh 

    2) chris.knight@ ~/code/sdks/xero-ruby/accounting (oauth_2_and_faraday) $ mv xero-ruby-0.4.0.gem xero-ruby.gem

    3) chris.knight@ ~/code/xero-ruby-oauth2-app/app (master) $ bundle

    4) chris.knight@ ~/code/xero-ruby-oauth2-app/app (master) $ rails s -p 5000

