class Unit < ActiveRecord::Base
  validates_presence_of :title
  has_many :days
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