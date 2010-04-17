require 'paperclip'
class Day < ActiveRecord::Base
  has_attached_file :lesson_plan
  belongs_to :unit

end

# == Schema Info
#
# Table name: days
#
#  id                       :integer         not null, primary ke
#  unit_id                  :integer
#  day_number               :integer
#  description              :text
#  lesson_plan_content_type :string(255)
#  lesson_plan_file_name    :string(255)
#  lesson_plan_file_size    :integer
#  title                    :string(255)
#  created_at               :datetime
#  lesson_plan_updated_at   :datetime
#  updated_at               :datetime