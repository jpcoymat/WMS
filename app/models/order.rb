class Order < ActiveRecord::Base

  validates	:order_number, :ship_date, :customer_id, :received_date, :ship_addres_1, :ship_city, :ship_country_id, :company_id, :presence => true
  validates	:order_number, :scope => :company_id, :uniqueness => true

  belongs_to	:company
  belongs_to	:customer
  belongs_to	:order_type
  
  has_many	:order_line  

  def ship_country
    @ship_country = Country.find(self.ship_country_id)
  end

end
