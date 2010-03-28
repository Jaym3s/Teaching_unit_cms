class DaysController < ApplicationController

  before_filter :find_day

  DAYS_PER_PAGE = 20

  def create
    @day = Day.new(params[:day])
    respond_to do |format|
      if @day.save
        flash[:notice] = 'Day was successfully created.'
        format.html { redirect_to @day }
        format.xml  { render :xml => @day, :status => :created, :location => @day }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @day.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @day.destroy
        flash[:notice] = 'Day was successfully destroyed.'        
        format.html { redirect_to days_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Day could not be destroyed.'
        format.html { redirect_to @day }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @days = Day.paginate(:page => params[:page], :per_page => DAYS_PER_PAGE)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @days }
    end
  end

  def edit
  end

  def new
    @units = Unit.all
    @day = Day.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @day }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @day }
    end
  end

  def update
    respond_to do |format|
      if @day.update_attributes(params[:day])
        flash[:notice] = 'Day was successfully updated.'
        format.html { redirect_to @day }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @day.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_day
    @day = Day.find(params[:id]) if params[:id]
  end

end