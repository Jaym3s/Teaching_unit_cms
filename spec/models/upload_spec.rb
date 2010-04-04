require 'spec_helper'

#  id                  :integer         not null, primary ke
#  lesson_id           :integer
#  upload_content_type :string(255)
#  upload_file_name    :string(255)
#  upload_file_size    :integer
#  created_at          :datetime
#  updated_at          :datetime
#  upload_updated_at   :datetime
describe Upload do
  it "validates presence of attached upload" do
    Upload.validates_attachment_presence :upload
  end
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