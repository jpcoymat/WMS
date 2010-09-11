class ProductStatus < ActiveRecord::Base

  validates	:code, :description, :company_id, :presence =>true
  validates	:code, :uniqueness => true

  belongs_to	:company

end
