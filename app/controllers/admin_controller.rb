class AdminController < ApplicationController
   before_filter :authenticate, :only=>[:index]
  def index
  end

  def logout
     session[:admin] = false
      redirect_to(home_index_url) 
  end

end
