class AddShowInTopToPicture < ActiveRecord::Migration
  def self.up
    add_column :pictures, :show_in_top, :boolean
  end

  def self.down
    remove_column :pictures, :show_in_top
  end
end
