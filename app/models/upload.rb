require 'paperclip'
class Upload < ActiveRecord::Base
  has_attached_file :upload# , :path => ":rails_root/:attachment/:id/:style.:extension"
  validates_attachment_presence :upload
end

# == Schema Info
#
# Table name: uploads
#
#  id                  :integer         not null, primary ke
#  upload_content_type :string(255)
#  upload_file_name    :string(255)
#  upload_file_size    :integer
#  created_at          :datetime
#  updated_at          :datetime
#  upload_updated_at   :datetime