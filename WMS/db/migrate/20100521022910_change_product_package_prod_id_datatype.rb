class ChangeProductPackageProdIdDatatype < ActiveRecord::Migration

  def self.up
	change_column	:product_packages, :product_id, :integer
  end

  def self.down
  end
end
