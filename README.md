# Xero NodeJS OAuth 2.0 App
This Ruby On Rails project demonstrates how to use the https://github.com/XeroAPI/xero-ruby SDK.

Its purpose is to speed up new ruby devs looking to build amazing applications with the data of users of the Xero Accounting platform: https://xero.com/. Secure authentication is setup using industry standard OAuth2.0. Access/Refresh tokens fuel authorized api calls.

Note: this project was built using:
* ruby 2.7.0
* Rails 6.0.2.2
* psql (PostgreSQL) 12.2

```
git clone git@github.com:XeroAPI/xero-ruby-oauth2-app.git
cd xero-ruby-oauth2-app
bundle install
```

### Configure with your credentials
* Create a [free Xero user account](https://www.xero.com/us/signup/api/)
* Login to your Xero developer [/myapps](https://developer.xero.com/myapps) dashboard & create an API application

Create a `.env` in the root of your project directory or replace the env.sample
```
CLIENT_ID=...
CLIENT_SECRET=...
REDIRECT_URI=...
```

## Start your server
```
bundle exec rake db:create db:migrate
rails s
```
> By default rails runs on port 3000. Make sure you have in your /myapps dashboard 'http://localhost:5000/callback' or specify the port with `rails s -p 8080` etc.

---

## Important structure
The project shows a strategy to effectively leverage the xero-ruby SDK. It is best documented by cloning/running the app but here are a few tips to quickly understanding the structure if you are not familair with Rails.

### Routes
* config/routes.rb will give a great picture of this apps functionality

### User model
* One table :users - utilizes [super basic authentication](https://gist.github.com/iscott/4618dc0c85acb3daa5c26641d8be8d0d).
* A JSON column :token_set that stores the entire `token_set` returned from the auth flow
* A string file `active_tenant_id` that references the actively selected tenant/org 

### Application Controller
Bulk of the auth flow logic. This uses a few helpers but shows how to handle the full authentication flow, refresh a token, disconnect an org, and even change which org you want to make api calls to.
* callback
* refresh_token
* change_organisation
* disconnect

## Application Helper
This includes some helpers that showcase how to decode the individual pieces of the `token_set` and show the multiple ways you can setup the `xero_client`, etc..
* token_expired
* id_token
* access_token
* current_user
* xero_client
* accounting_api
* authorization_url
* latest_connection

---

## Debugging
* put `-fail` or `binding.pry` in your code for an interactive brower or terminal shell where you can inspect the current request, manipulate results and see where your code went wrong ;)