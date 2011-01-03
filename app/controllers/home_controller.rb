class HomeController < ApplicationController
  def index
    @company_introduction = CompanyIntroduction.find_by_active(1)
    @news = News.all
    @contact = Contact.find_by_active(1)
    @video = Video.find(:first, :order=>"updated_at asc")
    @categories = Category.all
  end
  
  def pictures
    @pictures = Picture.find(:all)
  end

  def news
    @news = News.all
  end
end
