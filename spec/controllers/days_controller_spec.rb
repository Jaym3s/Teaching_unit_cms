require 'spec_helper'

describe DaysController do

  def mock_day(stubs={})
    @mock_day ||= mock_model(Day, stubs)
  end

  describe "POST create" do

    describe "with valid params" do
      it "redirects to the day's unit show page" do
        unit = mock_model(Unit)
        Day.stub(:new).and_return(mock_day(:unit => unit, :save => true))
        post :create, :day => {}
        response.should redirect_to(unit_url(unit))
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved day as @day" do
        Day.stub(:new).with({'these' => 'params'}).and_return(mock_day(:save => false))
        post :create, :day => {:these => 'params'}
        assigns[:day].should equal(mock_day)
      end

      it "re-renders the 'new' template" do
        Day.stub(:new).and_return(mock_day(:save => false))
        post :create, :day => {}
        response.should render_template('new')
      end
    end

  end

  describe "PUT update" do

    describe "with valid params" do
      it "updates the requested day" do
        Day.should_receive(:find).with("37").and_return(mock_day)
        mock_day.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :day => {:these => 'params'}
      end

      it "assigns the requested day as @day" do
        Day.stub(:find).and_return(mock_day(:update_attributes => true))
        put :update, :id => "1"
        assigns[:day].should equal(mock_day)
      end

      it "redirects to the day" do
        Day.stub(:find).and_return(mock_day(:update_attributes => true))
        put :update, :id => "1"
        response.should redirect_to(day_url(mock_day))
      end
    end

    describe "with invalid params" do
      it "updates the requested day" do
        Day.should_receive(:find).with("37").and_return(mock_day)
        mock_day.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, :id => "37", :day => {:these => 'params'}
      end

      it "assigns the day as @day" do
        Day.stub(:find).and_return(mock_day(:update_attributes => false))
        put :update, :id => "1"
        assigns[:day].should equal(mock_day)
      end

      it "re-renders the 'edit' template" do
        Day.stub(:find).and_return(mock_day(:update_attributes => false))
        put :update, :id => "1"
        response.should render_template('edit')
      end
    end

  end

  describe "DELETE destroy" do
    it "destroys the requested day" do
      Day.should_receive(:find).with("37").and_return(mock_day)
      mock_day.should_receive(:destroy)
      delete :destroy, :id => "37"
    end

    it "redirects to the days list" do
      Day.stub(:find).and_return(mock_day(:destroy => true))
      delete :destroy, :id => "1"
      response.should redirect_to(days_url)
    end
  end

end
