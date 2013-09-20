class AddWeightToProductPackage < ActiveRecord::Migration

  def self.up
    add_column :product_packages, :weight,:decimal,:scale => 2, :precision => 8
  end

  def self.down
  end
end
