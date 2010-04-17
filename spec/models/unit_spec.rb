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

  it "validates presence of Title" do
    # should_validate_presence_of x
    unit = Unit.new(:title => nil)
    unit.should_not be_valid
    unit.should have(1).error_on(:title)
  end
  it "returns a collection of days associated with it" do
    unit = Unit.create!(:title => "Test Unit 1")
    unit2 = Unit.create!(:title => "test unit 2")
    day1 = Day.create!(:title => "Day1", :unit => unit)
    day2 = Day.create!(:title => "Day2", :unit => unit2)
    day3 = Day.create!(:title => "Day3", :unit => unit)
    unit.days.should == [day1, day3]
  end
end


# == Schema Info
#
# Table name: units
#
#  id          :integer         not null, primary ke
#  description :text
#  subject     :string(255)
#  title       :string(255)
#  created_at  :datetime
#  updated_at  :datetime