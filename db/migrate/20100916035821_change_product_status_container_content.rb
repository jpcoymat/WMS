class ChangeProductStatusContainerContent < ActiveRecord::Migration

  def self.up
    rename_column :container_contents, :product_status, :product_status_id
  end

  def self.down
  end
end
