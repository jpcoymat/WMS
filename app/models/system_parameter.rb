class SystemParameter < ActiveRecord::Base

  validates	:code, :name, :description, :warehouse_id, :presence => true
  validates	:code, :scope => :warehouse_id, :uniqueness => true
  belongs_to    :warehouse


end
