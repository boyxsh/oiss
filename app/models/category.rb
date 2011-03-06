class Category < ActiveRecord::Base
  has_many :pictures
  has_attached_file :category, :storage => :s3, :s3_credentials => "#{RAILS_ROOT}/config/s3.yml", :path => "/:style/:filename"

  has_one:description
  accepts_nested_attributes_for :description
end
