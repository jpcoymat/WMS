class LocMixSku < ActiveRecord::Migration

  def self.up
	add_column :locations, :mix_sku, :boolean, :null => false, :default => false
  end

  def self.down
  end
end
