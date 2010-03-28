require 'spec_helper'

describe DaysController do
  describe "routing" do
    it "recognizes and generates #index" do
      { :get => "/days" }.should route_to(:controller => "days", :action => "index")
    end

    it "recognizes and generates #new" do
      { :get => "/days/new" }.should route_to(:controller => "days", :action => "new")
    end

    it "recognizes and generates #show" do
      { :get => "/days/1" }.should route_to(:controller => "days", :action => "show", :id => "1")
    end

    it "recognizes and generates #edit" do
      { :get => "/days/1/edit" }.should route_to(:controller => "days", :action => "edit", :id => "1")
    end

    it "recognizes and generates #create" do
      { :post => "/days" }.should route_to(:controller => "days", :action => "create") 
    end

    it "recognizes and generates #update" do
      { :put => "/days/1" }.should route_to(:controller => "days", :action => "update", :id => "1") 
    end

    it "recognizes and generates #destroy" do
      { :delete => "/days/1" }.should route_to(:controller => "days", :action => "destroy", :id => "1") 
    end
  end
end
