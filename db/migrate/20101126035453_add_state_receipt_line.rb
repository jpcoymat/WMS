class AddStateReceiptLine < ActiveRecord::Migration

  def self.up
    add_column  :receipt_lines, :state, :string, :limit => 50, :null => false
  end

  def self.down
  end
end
