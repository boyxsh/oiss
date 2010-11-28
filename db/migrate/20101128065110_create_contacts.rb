class CreateContacts < ActiveRecord::Migration
  def self.up
    create_table :contacts do |t|
      t.boolean :active
      t.string :address
      t.string :phone
      t.string :qq
      t.string :msn

      t.timestamps
    end
  end

  def self.down
    drop_table :contacts
  end
end
