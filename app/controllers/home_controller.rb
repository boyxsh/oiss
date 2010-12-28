class HomeController < ApplicationController
  def index
    @company_introduction = CompanyIntroduction.find_by_active(1)
    @news = News.all
    @contact = Contact.find_by_active(1)
  end
  
  def pictures
    @pictures = Picture.find(:all)
  end

end
