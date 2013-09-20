class SwitchToHasSecurePassword < ActiveRecord::Migration
  def self.up
    rename_column :users, :hashed_password, :password_digest
  end

  def self.down
  end
end
