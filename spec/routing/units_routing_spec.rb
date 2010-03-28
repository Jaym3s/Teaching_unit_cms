require 'spec_helper'

describe UnitsController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/units" }.should route_to(:controller => "units", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/units/new" }.should route_to(:controller => "units", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/units/1" }.should route_to(:controller => "units", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/units/1/edit" }.should route_to(:controller => "units", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/units" }.should route_to(:controller => "units", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/units/1" }.should route_to(:controller => "units", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/units/1" }.should route_to(:controller => "units", :action => "destroy", :id => "1") 
    end
  end
end
