class RenameStorStratLineRderSeq < ActiveRecord::Migration

  def self.up
	rename_column :storage_strategy_lines, :order_sequence_number, :order_sequence
  end

  def self.down
  end
end
