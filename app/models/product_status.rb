class ProductStatus < ActiveRecord::Base

  roomer :tenanted

  validates	:code, :description, :company_id, presence: true
  validates	:code, uniqueness: true

  belongs_to	:company

end
