class CreateDays < ActiveRecord::Migration
  def self.up
    create_table :days do |t|
      t.string :title
      t.text :description
      t.string :lesson_plan_file_name
      t.string :lesson_plan_content_type
      t.integer :lesson_plan_file_size
      t.datetime :lesson_plan_updated_at
      t.integer :unit_id

      t.timestamps
    end
  end

  def self.down
    drop_table :days
  end
end
