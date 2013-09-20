class AddUserFields < ActiveRecord::Migration

  def self.up
    add_column  :users, :dob,       :date,    :null => false
    add_column  :users, :email,     :string,  :null => false, :limit => 50
    add_column  :users, :position,  :string,  :limit => 50
  end

  def self.down
  end
end
