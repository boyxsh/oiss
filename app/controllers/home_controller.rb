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
      @pictures = nil
       @category_id = nil
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
end
