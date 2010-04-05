class UnitsController < ApplicationController

  before_filter :find_unit

  UNITS_PER_PAGE = 20

  def create
    @unit = Unit.new(params[:unit])
    respond_to do |format|
      if @unit.save
        flash[:notice] = 'Monkey add new Unit.'
        format.html { redirect_to @unit }
        format.xml  { render :xml => @unit, :status => :created, :location => @unit }
      else
        flash[:error] = 'Oops! the monkey that was supposed to save your data started flinging poo everywhere!'
        format.html { render :action => "new" }
        format.xml  { render :xml => @unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @unit.destroy
        flash[:notice] = 'Unit was successfully destroyed.'        
        format.html { redirect_to units_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Unit could not be destroyed.'
        format.html { redirect_to @unit }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @units = Unit.paginate(:page => params[:page], :per_page => UNITS_PER_PAGE)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @units }
    end
  end

  def edit
  end

  def new
    @unit = Unit.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @unit }
    end
  end

  def show
    @units = Unit.all
    respond_to do |format|
      format.html
      format.xml  { render :xml => @unit }
    end
  end

  def update
    respond_to do |format|
      if @unit.update_attributes(params[:unit])
        flash[:notice] = 'Unit was successfully updated.'
        format.html { redirect_to @unit }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @unit.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_unit
    @unit = Unit.find(params[:id]) if params[:id]
  end

end