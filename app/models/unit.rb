class Unit < ActiveRecord::Base
  validates_presence_of :title
end

# == Schema Info
#
# Table name: units
#
#  id          :integer         not null, primary ke
#  description :text
#  title       :string(255)
#  created_at  :datetime
#  updated_at  :datetime