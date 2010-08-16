class Lot < ActiveRecord::Base

  has_many  :products
  
  def self.all_lot_types
    ["Daily", "Weekly", "Monthly", "Bi-monthly", "Quarterly", "Semi-annual", "Annual"]
  end



end
