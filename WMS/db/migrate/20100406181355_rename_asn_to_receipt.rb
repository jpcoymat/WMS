class RenameAsnToReceipt < ActiveRecord::Migration
  def self.up
	rename_column :containers, :asn_id, :receipt_id
  end

  def self.down
  end
end
