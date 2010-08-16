class ReceiptType < ActiveRecord::Base

  belongs_to              :company
  has_many                :receipts
  has_many                :storage_strategy_rules
  validates_presence_of   :company_id, :code, :name
  validates_uniqueness_of :code, :scope => :company_id
  
  def deleteable?
    self.receipts.empty? and self.storage_strategy_rules.empty?
  end

end
