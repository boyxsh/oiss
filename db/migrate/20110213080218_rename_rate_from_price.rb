class RenameRateFromPrice < ActiveRecord::Migration
  def self.up
    rename_column :prices, :rate, :val
  end

  def self.down
    remove_column :prices, :val, :rate
  end
end
