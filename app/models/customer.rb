class Customer < ActiveRecord::Base

  belongs_to :customer_type
  belongs_to :company 

  validates :company_id, :name, :address_1, :city, :country_id, presence: true
  validates :name, uniqueness: true

end
