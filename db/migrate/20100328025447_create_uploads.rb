class CreateUploads < ActiveRecord::Migration
  def self.up
    create_table :uploads do |t|
      t.string :upload_content_type
      t.string :upload_file_name
      t.integer :upload_file_size
      t.datetime :upload_updated_at
      t.integer :day_id

      t.timestamps
    end
  end

  def self.down
    drop_table :uploads
  end
end
