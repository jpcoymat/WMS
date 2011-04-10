class AddWebsiteToSuppliers < ActiveRecord::Migration

  def self.up
	add_column :suppliers, :website, :string, :limit => 100
  end

  def self.down
  end
end
