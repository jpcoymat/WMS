class SysparmBooleanValue < ActiveRecord::Migration

  def self.up
    remove_column :system_parameters, :value
    add_column    :system_parameters, :value, :boolean
  end

  def self.down
  end
end
