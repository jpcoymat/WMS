require 'digest/sha1'

class User < ActiveRecord::Base

  validates	:username, :length => {:within => 3..40}
  validates	:username, :first_name, :last_name, :email, :warehouse_id, :hashed_password, :presence => true
  validates	:username, :uniqueness => true

  validates	:password, :confirmation => true

  validate 	:password_must_be_present

  attr_accessor	:password, :password_confirmation
  
  belongs_to 	:warehouse
  
  after_save :flush_passwords


  def password_must_be_present
    errors.add(:password, "Missing password" ) unless hashed_password.present?
  end

  def self.sex
    ["Male", "Female"]
  end
  
  def self.authenticate(username, password)
    user = first(:conditions => ["username = ?", username])
    unless user.nil?
      expected_password = Digest::SHA1.hexdigest(password)
      if user.hashed_password != expected_password
        user = nil
      end
    end
    user 
  end

  def password
    @password
  end
  
  
  def password=(pwd)
    @password = pwd
    return if pwd.blank?
    self.hashed_password = Digest::SHA1.hexdigest(self.password)
  end

  def company
    @company = self.warehouse.company
  end
  
  def full_name
    @full_name = self.first_name + " " + self.last_name
  end
  
  private
  
    def flush_passwords
      @password = @password_confirmation = nil
    end
      

end
