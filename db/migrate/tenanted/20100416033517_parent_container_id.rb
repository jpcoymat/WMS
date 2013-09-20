class ParentContainerId < ActiveRecord::Migration

  def self.up
    add_column  :containers,  :parent_container_id, :integer
  end

  def self.down
    remove_column :containers,  :parent_container_id
  end
end
