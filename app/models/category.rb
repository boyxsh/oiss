class Category < ActiveRecord::Base
  has_many :pictures
  has_attached_file :category
end
