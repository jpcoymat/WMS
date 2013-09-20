class AddCompanyLogo < ActiveRecord::Migration
  def self.up
	add_column :companies, :logo_filename, :string, :limit => 100
  end

  def self.down
	remove_column :companies, :logo_filename
  end
end
