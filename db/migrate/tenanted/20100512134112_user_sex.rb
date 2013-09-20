class UserSex < ActiveRecord::Migration

  def self.up
    add_column :users, :sex, :string, :null => false, :limit => 10
  end

  def self.down
    remove_column :users, :sex
  end
end
