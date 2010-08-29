class DockDoor < ActiveRecord::Base

	belongs_to              :warehouse
	validates_presence_of	  :name, :direction, :warehouse_id
	validates_uniqueness_of	:name, :scope => :warehouse_id

  def self.directions
    ["Inbound", "Outbound", "Both"]
  end

end
