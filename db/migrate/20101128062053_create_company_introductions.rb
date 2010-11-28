class CreateCompanyIntroductions < ActiveRecord::Migration
  def self.up
    create_table :company_introductions do |t|
      t.boolean :active
      t.text :content

      t.timestamps
    end
  end

  def self.down
    drop_table :company_introductions
  end
end
