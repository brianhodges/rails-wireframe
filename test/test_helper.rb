ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  
  def random_string(len)
    WFLib.random_string len
  end
  
  def pword
    return 'password'
  end
  
  def username
    return 'TestUsername'
  end
  
  def salt
    salt = SCrypt::Engine.generate_salt
    return salt
  end
  
  def hash
    hash = SCrypt::Engine.hash_secret(pword, salt)
    return hash
  end
  
  def make_reference_data
    @admin_role = Role.create role: WFConsts::ADMIN
    Role.create role: WFConsts::USER
    @admin_user = User.create username: username, password: pword, password_confirmation: pword,
        role_id: @admin_role.id, password_salt: salt, password_hash: hash
  end
  
  def make_session
		post sessions_url, params: { username: "TestUsername", password: pword }
  end
  
  def make_user(save)
    u = User.new
    u.username = random_string 25
    u.role = @admin_role
    u.password_salt = salt
    u.password_hash = hash
    u.password = pword
    u.password_confirmation = pword
    assert u.save, "make_user" if save
    u
  end
  
  def make_user_params
    user = {}
    user[:username] = random_string 25
    user[:role_id] = @admin_role.id
    user[:password_salt] = salt
    user[:password_hash] = hash
    user[:password] = pword
    user[:password_confirmation] = pword
    user  
  end
  
  def make_role(save)
    r = Role.new
    r.role = random_string 20
    assert r.save, "make_role" if save
    r
  end
  
  def make_role_params
    role = {}
    role[:role] = random_string 20
    role
  end
end
