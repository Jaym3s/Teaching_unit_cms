class UploadsController < ApplicationController

  before_filter :find_upload

  UPLOADS_PER_PAGE = 20

  def create
    @upload = Upload.create(params[:upload])
    respond_to do |format|
      if @upload
        flash[:notice] = 'Upload was successfully created.'
        format.html { redirect_to @upload }
        format.xml  { render :xml => @upload, :status => :created, :location => @upload }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    respond_to do |format|
      if @upload.destroy
        flash[:notice] = 'Upload was successfully destroyed.'        
        format.html { redirect_to uploads_path }
        format.xml  { head :ok }
      else
        flash[:error] = 'Upload could not be destroyed.'
        format.html { redirect_to @upload }
        format.xml  { head :unprocessable_entity }
      end
    end
  end

  def index
    @uploads = Upload.paginate(:page => params[:page], :per_page => UPLOADS_PER_PAGE)
    respond_to do |format|
      format.html
      format.xml  { render :xml => @uploads }
    end
  end

  def edit
  end

  def new
    @upload = Upload.new
    respond_to do |format|
      format.html
      format.xml  { render :xml => @upload }
    end
  end

  def show
    respond_to do |format|
      format.html
      format.xml  { render :xml => @upload }
    end
  end

  def update
    respond_to do |format|
      if @upload.update_attributes(params[:upload])
        flash[:notice] = 'Upload was successfully updated.'
        format.html { redirect_to @upload }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @upload.errors, :status => :unprocessable_entity }
      end
    end
  end

  private

  def find_upload
    @upload = Upload.find(params[:id]) if params[:id]
  end

end