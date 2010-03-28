require 'spec_helper'

# Table name: units
#
#  id          :integer         not null, primary ke
#  description :text
#  subject     :string(255)
#  title       :string(255)
#  created_at  :datetime
#  updated_at  :datetime

describe Unit do
  before(:each) do
    @valid_attributes = {
      
    }
  end

  it "should create a new instance given valid attributes" do
    Unit.create!(@valid_attributes)
  end
end
