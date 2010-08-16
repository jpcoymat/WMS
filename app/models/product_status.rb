class ProductStatus < ActiveRecord::Base

  validates_presence_of     :code, :description, :company_id
  validates_uniqueness_of   :code, :scope => :company_id



end
