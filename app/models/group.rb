class Group < ActiveRecord::Base
  has_attached_file :avatar,
  :storage => :s3,
  :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
  :path => "/:style/:id/:filename"
end
