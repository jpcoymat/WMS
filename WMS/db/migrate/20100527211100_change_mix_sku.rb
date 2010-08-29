class ChangeMixSku < ActiveRecord::Migration

  def self.up
	rename_column :locations, :mix_sku, :mix_products
  end

  def self.down
  end
end
