class DescriptionsController < ApplicationController

  def index
    @description = Description.where(:category_id => nil)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @description}
    end
  end

  def new
    @description = Description.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @description }
    end
  end

  def create
    @description = Description.new(params[:description])

    respond_to do |format|
      if @description.save
        format.html { redirect_to(@description, :notice => ' Description was successfully created.') }
        format.xml  { render :xml => @description, :status => :created, :location => @description }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @news.errors, :status => :unprocessable_entity }
      end
    end
  end

  def show
    @description = Description.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @description }
    end
  end

  def update
    @description = Description.find(params[:id])

    respond_to do |format|
      if @description.update_attributes(params[:description])
        format.html { redirect_to(@description, :notice => 'Description was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @description.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @description = Description.find(params[:id])
    @description.destroy

    respond_to do |format|
      format.html { redirect_to(descriptions_url) }
      format.xml  { head :ok }
    end
  end

  def edit
    @description = Description.find(params[:id])
  end
end
