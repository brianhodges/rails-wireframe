class User < ApplicationRecord
  attr_accessor :password
  belongs_to :role
  validates_confirmation_of :password
  validates_presence_of :password
  validates_presence_of :username
  validates_uniqueness_of :username
  before_save { |user| user.username = user.username.downcase }
  before_save :encrypt_password

  def encrypt_password
    if password.present?
      self.password_salt = SCrypt::Engine.generate_salt
      self.password_hash = SCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(username, password)
    u = find_by_username(username.downcase)
    return u if u && u.password_hash == SCrypt::Engine.hash_secret(password, u.password_salt)
  end
end
