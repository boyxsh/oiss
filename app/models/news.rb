class News < ActiveRecord::Base
	validates_presence_of :title, :content, :message=>"can't be blank!!!!!"
	validates_uniqueness_of :title, :message=>"'%{value}' haved in english"
end
