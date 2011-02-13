class AddElementsToContact < ActiveRecord::Migration
  def self.up
    add_column :contacts, :telephone, :string
    add_column :contacts, :email, :string
  end

  def self.down
    remove_column :contacts, :telephone
    remove_column :contacts, :email
  end
end
