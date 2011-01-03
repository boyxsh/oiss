class AddCategoryToPicuture < ActiveRecord::Migration
  def self.up
    add_column :pictures, :category_id, :string
  end

  def self.down
    remove_column :pictures, :category_id
  end
end