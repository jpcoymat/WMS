class Receipt < ActiveRecord::Base

  validates	:estimated_receipt_date, :company_id, :receipt_number, :presence => true
  validates	:receipt_number, :uniqueness => true
  
  belongs_to    :company
  belongs_to    :supplier
  
  has_many      :receipt_lines
  



end
