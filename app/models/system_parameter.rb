class SystemParameter < ActiveRecord::Base

  validates_presence_of     :code, :name, :description, :warehouse_id
  validates_uniqueness_of   :code, :scope => :warehouse_id
  belongs_to                :warehouse


end
