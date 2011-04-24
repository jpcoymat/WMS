class AddWaveIdToOrderLines < ActiveRecord::Migration

  def self.up
    add_column :order_lines, :wave_id, :integer 
  end

  def self.down
  end
end
