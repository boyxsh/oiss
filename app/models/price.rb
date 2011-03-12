class Price < ActiveRecord::Base
  has_attached_file :icon,
  :storage => :s3,
  :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
  :path => "/:style/:id/:filename"
  has_attached_file :rate
end
