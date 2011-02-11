class HomeController < ApplicationController
  def index
    @pictures = Picture.find(:all, :conditions => {:show_in_top => 1})
    @news = News.all
    @contact = Contact.find_by_active(1)
    @video = Video.find(:first, :order=>"updated_at asc")
    @categories = Category.all
  end
  
  def pictures
    if params[:id].blank?
      tmp = Category.find(:first)
      @pictures = tmp.pictures
      @category_id = tmp.id
    else
      @pictures = Category.find_by_id(params[:id]).pictures
      @category_id = params[:id]
    end
    @categories = Category.find(:all)
  end

  def news
    @news = News.all
    @show_news = params[:id].blank? ? @news.first :  News.find_by_id(params[:id])
  end
  
  def themes
    @id = params[:id].blank?

   if @id
      @categories =  Category.all     
      description = Description.where(:category_id => nil)
      description.each do |d| 
        @title = d.title
        @body = d.body
      end
   else
    @categories = Category.find_by_id(params[:id])
    @title = @categories.name
    @body = @categories.description.body
   end
  end

  def groups
      @group = Group.find(:last)
  end
  
  def company_introductions
    @company_introduction = params[:id].blank? ? CompanyIntroduction.find(:first) :  CompanyIntroduction.find_by_id(params[:id])
  end
  
  def prices
    @prices = Price.all
  end

  def price_detail
    unless params[:id].blank?
      @price = Price.find_by_id(params[:id])
    end
  end
end
