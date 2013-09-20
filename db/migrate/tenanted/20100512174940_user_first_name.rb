class UserFirstName < ActiveRecord::Migration

  def self.up
    rename_column :users, :name, :first_name
  end

  def self.down
  end
end
