class Receipt < ActiveRecord::Base

  validates	:estimated_receipt_date, :warehouse_id, :receipt_number, :presence => true
  validates	:receipt_number, :uniqueness => true
  
  belongs_to    :warehouse
  belongs_to    :supplier
  
  has_many      :receipt_lines
  



end
