class AccountingController < ActionController::Base
  require 'xero-ruby'

  def invoices
    # config = {
    #   client_id: "902DD32276574ED199639D9226A425B1",
    #   client_secret: 'PeNYDifbqi4Q3l9mG_kTg3LdLZ7RIUFpOOas-16sqkPV_e5C',
    #   redirect_uri: 'http://localhost:5000/callback',
    #   debugging: false,
    #   client_side_validation: false
    # }
    # xero_client = XeroRuby::ApiClient.new(config)
    
    # xero_client.config[:access_token] = "eyJhbGciOiJSUzI1NiIsImtpZCI6IjFDQUY4RTY2NzcyRDZEQzAyOEQ2NzI2RkQwMjYxNTgxNTcwRUZDMTkiLCJ0eXAiOiJKV1QiLCJ4NXQiOiJISy1PWm5jdGJjQW8xbkp2MENZVmdWY09fQmsifQ.eyJuYmYiOjE1ODU5NDM3MjUsImV4cCI6MTU4NTk0NTUyNSwiaXNzIjoiaHR0cHM6Ly9pZGVudGl0eS54ZXJvLmNvbSIsImF1ZCI6Imh0dHBzOi8vaWRlbnRpdHkueGVyby5jb20vcmVzb3VyY2VzIiwiY2xpZW50X2lkIjoiOTAyREQzMjI3NjU3NEVEMTk5NjM5RDkyMjZBNDI1QjEiLCJzdWIiOiJkYjRmMGYzN2I1ODU1MzBlOTFmM2I5Y2JiNTAzNDBlOCIsImF1dGhfdGltZSI6MTU4NTk0MzcxNywieGVyb191c2VyaWQiOiJmYWE4M2VjOS1mNmE3LTQ4OWYtODkxMS1lM2ZjZTAzYTExODYiLCJnbG9iYWxfc2Vzc2lvbl9pZCI6Ijk0YmQ1NWM4ZWZhNTQ3NzhiNzU1MDg5MGE2OTVjZDljIiwianRpIjoiNDg1YWVlNjdmZjRlY2QyNDQxZWJmOWI3OTFkZDNiYjkiLCJzY29wZSI6WyJlbWFpbCIsInByb2ZpbGUiLCJvcGVuaWQiLCJhY2NvdW50aW5nLnJlcG9ydHMucmVhZCIsImFjY291bnRpbmcuYXR0YWNobWVudHMucmVhZCIsImZpbGVzIiwicHJvamVjdHMucmVhZCIsInByb2plY3RzIiwiYWNjb3VudGluZy5zZXR0aW5ncyIsImFjY291bnRpbmcuc2V0dGluZ3MucmVhZCIsImFjY291bnRpbmcuYXR0YWNobWVudHMiLCJhY2NvdW50aW5nLnRyYW5zYWN0aW9ucyIsImFjY291bnRpbmcuam91cm5hbHMucmVhZCIsImFjY291bnRpbmcudHJhbnNhY3Rpb25zLnJlYWQiLCJhc3NldHMucmVhZCIsImFzc2V0cyIsImFjY291bnRpbmcuY29udGFjdHMiLCJhY2NvdW50aW5nLmNvbnRhY3RzLnJlYWQiLCJvZmZsaW5lX2FjY2VzcyJdfQ.qS-S9t_79a7-7IspnaOaRuXTdLOi6ovmvFgYrye_1d-i3fbwzhip121nNjkWe-It6d7LmszBnpGBTRgcP8wTu3bEV4RnEbEVfB1mwQDXRnt-mb9GHmG7-tOCPheMocAfoAnMGOSiFRisw2D9BTUj2VejiGfQhY_L-wfo_IE3-_tqe0qBAvyGHs-bSnJMO_verDe_EnnRE62dpQmEJtS2G7v8--cLxOywNIi6eNaysM4I7RiBR8Bzb7bId0-vMOSubsYZYbqNcLvYvXx2Y12Q33dQDsXimgze5P4st4vo7QXBAdTDWoVwfFxsSQ6o9uO4ZGsUgDzfsIF2HbVvZ50wFQ"
    
    # xero_accounting_client = XeroRuby::AccountingApi.new(xero_client)
    
    # invoices = xero_accounting_client.get_invoices("b0948bbc-051d-466c-910e-176ad4d56275")
    
    accounting_api = XeroRuby::AccountingApi.new
    xero_tenant_id = 'b0948bbc-051d-466c-910e-176ad4d56275' # String | Xero identifier for Tenant

    @invoices = accounting_api.get_invoices(xero_tenant_id).invoices

  end
end
