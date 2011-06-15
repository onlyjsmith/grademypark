# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110615144056) do

  create_table "countries", :force => true do |t|
    t.string   "long_name"
    t.string   "short_name"
    t.integer  "iso_3"
    t.integer  "pa_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "review_count"
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.integer  "wdpa_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "review_count"
    t.integer  "total_rating"
    t.integer  "avg_rating"
    t.integer  "country_id"
    t.string   "designation"
    t.float    "reported_area"
  end

  create_table "reviews", :force => true do |t|
    t.integer  "rating"
    t.integer  "wildness"
    t.integer  "management"
    t.string   "review_text"
    t.string   "contact_details"
    t.integer  "review_value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "place_id"
  end

  create_table "richcontents", :force => true do |t|
    t.string   "content_name"
    t.string   "content_url"
    t.integer  "review_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "content_type"
    t.string   "prefix"
  end

  create_table "starratings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "place_id"
    t.integer  "aspect"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "review_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
  end

end
