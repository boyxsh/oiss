class Price < ActiveRecord::Base
  has_attached_file :icon
  has_attached_file :rate
end
