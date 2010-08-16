class FixAddresss2 < ActiveRecord::Migration

  def self.up
    rename_column :warehouses, :addresss_2, :address_2
  end

  def self.down
  end
end
