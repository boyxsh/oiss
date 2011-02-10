class Category < ActiveRecord::Base
  has_many :pictures
  has_attached_file :category

  has_one:description
  accepts_nested_attributes_for :description
end
