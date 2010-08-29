class Receipt < ActiveRecord::Base

  validates_presence_of   :estimated_receipt_date, :company_id, :receipt_number
  validates_uniqueness_of :receipt_number, :scope => :company_id
  
  belongs_to              :company
  belongs_to              :supplier
  belongs_to              :purchase_order
  
  has_many                :receipt_lines
  



end
