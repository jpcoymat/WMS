class AddWarehouseId < ActiveRecord::Migration

  def self.up
    add_column :allocation_zones, :warehouse_id, :integer
    add_column :storage_zones, :warehouse_id, :integer
    add_column :dock_doors, :warehouse_id, :integer
    add_column :product_categories, :company_id, :integer
    add_column :product_subcategories, :company_id, :integer
    add_column :suppliers, :company_id, :integer
    add_column :system_parameters, :warehouse_id, :integer
    add_column :users, :warehouse_id, :integer
    add_column :uoms, :company_id, :integer
  end

  def self.down
    remove_column :allocation_zones, :warehouse_id
    remove_column :storage_zones, :warehouse_id 
    remove_column :dock_doors, :warehouse_id
    remove_column :product_categories, :company_id
    remove_column :product_subcategories, :company_id
    remove_column :suppliers, :company_id
    remove_column :system_parameters, :warehouse_id
    remove_column :users, :warehouse_id
    remove_column :uoms, :company_id
  end
end
