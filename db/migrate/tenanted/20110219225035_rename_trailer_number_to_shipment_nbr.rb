class RenameTrailerNumberToShipmentNbr < ActiveRecord::Migration

  def self.up
	rename_column :shipments, :trailer_number, :shipment_number 
  end

  def self.down
  end
end
