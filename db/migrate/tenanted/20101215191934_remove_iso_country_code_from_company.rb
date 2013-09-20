class RemoveIsoCountryCodeFromCompany < ActiveRecord::Migration

  def self.up
	remove_column :companies, :iso_country_code
  end

  def self.down
  end
end
