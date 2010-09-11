class Lot < ActiveRecord::Base

  has_many  :products
  validates :product_id, :fifo_date, :product_status, :name, :presence => true
  validates :name, :scope => product_id, :uniquenes => true 
  
  def self.all_lot_types
    ["Daily", "Weekly", "Monthly", "Bi-monthly", "Quarterly", "Semi-annual", "Annual"]
  end



end
