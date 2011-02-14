class ChangeAssigmentType < ActiveRecord::Migration

  def self.up
    remove_column :assignments, :assignment_type_id
    add_column    :assignments, :type, :string, :limit => 25, :null => false
  end

  def self.down
  end
end
