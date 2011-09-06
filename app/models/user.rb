require 'digest/sha1'

class User < ActiveRecord::Base

  validates	:username, :length => {:within => 3..40}
  validates	:username, :first_name, :last_name, :email, :warehouse_id, :presence => true
  validates	:username, :uniqueness => true

  has_secure_password
  belongs_to 	:warehouse
  

  def self.sex
    ["Male", "Female"]
  end
    
  def company
    @company = self.warehouse.company
  end
  
  def full_name
    @full_name = self.first_name + " " + self.last_name
  end
      

end
