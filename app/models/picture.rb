class Picture < ActiveRecord::Base
  has_attached_file :attachment,
  :styles => {
    :thumb  => "60x60#",
    :medium => "960x400>",
  },
    :storage => :s3,
    :s3_credentials => "#{RAILS_ROOT}/config/s3.yml",
    :path => "/:style/:id/:filename"
  
  belongs_to :category
  
  CATEGROY_HASH = {'1' => 'blue', '2' => 'pink', '3' => 'red', '4' => 'purple'}
end
