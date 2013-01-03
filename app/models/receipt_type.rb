class ReceiptType < ActiveRecord::Base

  belongs_to	:company
  has_many	:receipts
  has_many	:storage_strategy_rules
  validates	:company_id, :code, :name, presence: true
  validates	:code, uniqueness: true
  
  def deleteable?
    self.receipts.empty? and self.storage_strategy_rules.empty?
  end

end
