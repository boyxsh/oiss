class CompanyIntroductionsController < ApplicationController
  # GET /company_introductions
  # GET /company_introductions.xml
  def index
    @company_introductions = CompanyIntroduction.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @company_introductions }
    end
  end

  # GET /company_introductions/1
  # GET /company_introductions/1.xml
  def show
    @company_introduction = CompanyIntroduction.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @company_introduction }
    end
  end

  # GET /company_introductions/new
  # GET /company_introductions/new.xml
  def new
    @company_introduction = CompanyIntroduction.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @company_introduction }
    end
  end

  # GET /company_introductions/1/edit
  def edit
    @company_introduction = CompanyIntroduction.find(params[:id])
  end

  # POST /company_introductions
  # POST /company_introductions.xml
  def create
    @company_introduction = CompanyIntroduction.new(params[:company_introduction])

    respond_to do |format|
      if @company_introduction.save
        format.html { redirect_to(@company_introduction, :notice => 'Company introduction was successfully created.') }
        format.xml  { render :xml => @company_introduction, :status => :created, :location => @company_introduction }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @company_introduction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /company_introductions/1
  # PUT /company_introductions/1.xml
  def update
    @company_introduction = CompanyIntroduction.find(params[:id])

    respond_to do |format|
      if @company_introduction.update_attributes(params[:company_introduction])
        format.html { redirect_to(@company_introduction, :notice => 'Company introduction was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @company_introduction.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /company_introductions/1
  # DELETE /company_introductions/1.xml
  def destroy
    @company_introduction = CompanyIntroduction.find(params[:id])
    @company_introduction.destroy

    respond_to do |format|
      format.html { redirect_to(company_introductions_url) }
      format.xml  { head :ok }
    end
  end
end
