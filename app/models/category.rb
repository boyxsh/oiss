class Category < ActiveRecord::Base
  has_many :pictures
  has_attached_file :category,
  :styles => {
    :thumb  => "140x180#",
    :medium => "800x600>",
  },
    :storage => :s3,
    :bucket => ENV['S3_BUCKET'],
    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
    :path => "/:style/:id/:filename"

  has_one:description
  accepts_nested_attributes_for :description
end
