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
    unit = Unit.new(:title => nil)
    unit.should_not be_valid
    unit.should have(1).error_on(:title)
  end
end
