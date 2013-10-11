require 'digest/sha1'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, 
    :warehouse_id, :first_name, :last_name, :username, :dob, :position, :sex

  validates	:username, length: {:within => 3..40}
  validates	:username, :first_name, :last_name, :email, :warehouse_id, presence: true
  validates	:username, uniqueness: true

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
