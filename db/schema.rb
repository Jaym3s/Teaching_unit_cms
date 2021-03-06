# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100328025447) do

  create_table "days", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "lesson_plan_file_name"
    t.string   "lesson_plan_content_type"
    t.integer  "lesson_plan_file_size"
    t.datetime "lesson_plan_updated_at"
    t.integer  "unit_id"
    t.integer  "day_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "units", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "subject"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "uploads", :force => true do |t|
    t.string   "upload_content_type"
    t.string   "upload_file_name"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.integer  "day_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
