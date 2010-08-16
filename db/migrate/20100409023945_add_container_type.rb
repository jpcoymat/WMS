class AddContainerType < ActiveRecord::Migration

  def self.up
	add_column :containers, :container_type_id, :integer 
  end

  def self.down
  end
end
