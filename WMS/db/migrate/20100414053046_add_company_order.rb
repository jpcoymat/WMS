class AddCompanyOrder < ActiveRecord::Migration

  def self.up
    add_column :orders, :company_id, :integer
  end

  def self.down
    remove_column :orders, :company_id
  end
end
