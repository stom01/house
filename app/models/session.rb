class Session < ApplicationRecord
  before_create :hash_password

  def hash_password
    self.salt = BCrypt::Engine.generate_salt
    self.password = BCrypt::Engine.hash_secret(password, salt)
  end

  def self.is_valid?(id, token)
    record = find_by(id: id)
    return false if record.blank?
    record.password == BCrypt::Engine.hash_secret(token, record.salt)
  end

  def self.clear_session(id)
    record = find_by(id: id)
    record.destroy if record
  end
end
