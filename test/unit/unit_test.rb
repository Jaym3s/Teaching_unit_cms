require 'test_helper'

class UnitTest < ActiveSupport::TestCase
  # Replace this with your real tests.
  test "the truth" do
    assert true
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