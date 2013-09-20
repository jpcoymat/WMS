class AddLotName < ActiveRecord::Migration

  def self.up
	add_column	:lots, :name, :string, :null => false, :limit => 25
  end

  def self.down
  end
end
