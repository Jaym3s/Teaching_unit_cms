class DaysController < ApplicationController

  before_filter :find_day

  DAYS_PER_PAGE = 20

  def create
    @day = Day.new(params[:day])
    respond_to do |format|
      if @day.save
        flash[:notice] = 'Monkey add new day'
        format.html { redirect_to @day.unit }
        format.xml  { render :xml => @day, :status => :created, :location => @day.unit }
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
    @units = Unit.all
  end

  def new
    @day = Day.new(:unit => Unit.find(params[:unit_id]))
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