class ContainerLocationPolymorphic < ActiveRecord::Migration

  def self.up
    #add_column  :containers, :container_location_type,  :string,  :null => false,   :limit => 25
    #add_column  :containers, :container_location_id,    :integer, :null => false
  end

  def self.down
    remove_column :containers,  :container_location_type
    remove_column :containers,  :container_location_id
  end
end
