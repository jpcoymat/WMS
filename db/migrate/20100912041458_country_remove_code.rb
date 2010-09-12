class CountryRemoveCode < ActiveRecord::Migration

  def self.up
	remove_column :countries, :code
  end

  def self.down
  end
end
