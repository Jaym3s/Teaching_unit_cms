require 'spec_helper'

describe Unit do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Unit.create!(@valid_attributes)
  end
end
