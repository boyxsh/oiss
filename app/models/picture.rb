class Picture < ActiveRecord::Base
  has_attached_file :attachment
  
  belongs_to :category
  
  CATEGROY_HASH = {'1' => 'blue', '2' => 'pink', '3' => 'red', '4' => 'purple'}
end
