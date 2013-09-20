class AddStateToReceipts < ActiveRecord::Migration
  def self.up
    add_column :receipts, :state, :string, :limit => 50, :null => false
  end

  def self.down
  end
end
