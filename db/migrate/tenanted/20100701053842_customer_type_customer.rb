class CustomerTypeCustomer < ActiveRecord::Migration

  def self.up
    add_column  :customers, :customer_type_id, :integer
  end

  def self.down
  end
end
