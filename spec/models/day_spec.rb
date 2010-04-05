require 'spec_helper'

#  id                       :integer         not null, primary ke
#  unit_id                  :integer
#  description              :text
#  lesson_plan_content_type :string(255)
#  lesson_plan_file_name    :string(255)
#  lesson_plan_file_size    :integer
#  title                    :string(255)
#  created_at               :datetime
#  lesson_plan_updated_at   :datetime
#  updated_at               :datetime

describe Day do
  before(:each) do
    @valid_attributes = {
      :unit_id => 1,
      :description => "asdf",
      :title => "asdf"
    }
  end

  it "should create a new instance given valid attributes" do
    day = Day.create!(@valid_attributes)
    Day.first.should == day
  end
  it "should link to it's respective unit" do
    unit = Unit.create!(:title => "some title")
    day = Day.create!(:unit_id => unit)
    day.unit.should == unit
  end
end
