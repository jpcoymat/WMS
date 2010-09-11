class ProductStatus < ActiveRecord::Base

  validates	:code, :description, :company_id, :presence =>true
  validates	:code, :scope => :company_id, :uniqueness => true

  belongs_to	:company

end
