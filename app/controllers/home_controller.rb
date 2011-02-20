class HomeController < ApplicationController
  def get_last_active_contact
    @contact = Contact.find(:last, :conditions =>{:active=>1})
  end

  def index
    @pictures = Picture.find(:all, :conditions => {:show_in_top => true})
    @news = News.all
    @video = Video.find(:first, :order=>"updated_at asc")
    @categories = Category.all
    get_last_active_contact
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
    get_last_active_contact
  end

  def news
    get_last_active_contact
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

    get_last_active_contact
  end

  def groups
    get_last_active_contact
      @group = Group.find(:last)
  end
  
  def company_introductions
    get_last_active_contact
    @company_introduction = params[:id].blank? ? CompanyIntroduction.find(:first) :  CompanyIntroduction.find_by_id(params[:id])
  end
  
  def prices
    @prices = Price.all
    get_last_active_contact
  end

  def price_detail
    unless params[:id].blank?
      @price = Price.find_by_id(params[:id])
    end
    get_last_active_contact
  end
end
