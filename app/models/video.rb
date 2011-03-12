class Video < ActiveRecord::Base
  has_attached_file :attachment,
  :storage => :s3,
  :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
  :path => "/:style/:id/:filename"
end
