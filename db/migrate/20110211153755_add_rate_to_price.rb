class AddRateToPrice < ActiveRecord::Migration
  def self.up
    add_column :prices, :rate_file_name, :string
    add_column :prices, :rate_content_type, :string
    add_column :prices, :rate_file_size, :integer
    add_column :prices, :rate_updated_at, :datetime
  end

  def self.down
    remove_column :prices, :rate_file_name
    remove_column :prices, :rate_content_type
    remove_column :prices, :rate_file_size
    remove_column :prices, :rate_updated_at
  end
end
