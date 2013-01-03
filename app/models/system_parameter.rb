class SystemParameter < ActiveRecord::Base

  validates	:code, :name, :description, :warehouse_id, presence: true
  validates	:code, uniqueness: true
  belongs_to    :warehouse


end
