class User < ApplicationRecord
  require 'json'
  has_secure_password

  validates :email, presence: true, uniqueness: true

  def set_token_set_from_file
    file_contents = File.read(Rails.root + 'app/data/token_set.json')
    token_set = JSON.parse(JSON.parse(file_contents))
    
    puts "Setting token set: #{token_set}"
    self.update!(token_set: token_set)

    puts "Setting active Xero tenant id: #{token_set}"
    self.update!(active_tenant_id: token_set['xero_tenant_id'])
  end
end

# user = User.find_by_email 'chris.knight@xero.com'
# user.set_token_set_from_file