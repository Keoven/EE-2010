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

ActiveRecord::Schema.define(:version => 20100521083600) do

  create_table "admins", :force => true do |t|
    t.string   "login"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "candidates", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "position"
    t.string   "level"
    t.integer  "num_votes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "province"
    t.string   "municipality"
    t.integer  "district"
  end

  create_table "pending_ballots", :force => true do |t|
    t.string   "ballot_key"
    t.string   "voter_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.integer  "street_number"
    t.string   "street_name"
    t.string   "district_code"
    t.string   "municipality_code"
    t.string   "provincial_code"
    t.string   "voter_id"
    t.date     "birth_date"
    t.string   "email"
    t.boolean  "voted"
    t.boolean  "activated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
