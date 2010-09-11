class Customer < ActiveRecord::Base

  belongs_to :customer_type

  validates :company_id, :name, :address_1, :city, :country_id, :presence => true
  validates :name, :scope => :company_id, :uniqueness => true

end
