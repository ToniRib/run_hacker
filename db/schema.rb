# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160305154907) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "locations", force: :cascade do |t|
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "routes", force: :cascade do |t|
    t.float    "starting_latitude"
    t.float    "starting_longitude"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.float    "elevation"
    t.integer  "location_id"
  end

  add_index "routes", ["location_id"], name: "index_routes_on_location_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "token"
    t.string   "provider"
    t.integer  "uid"
    t.string   "display_name"
    t.string   "username"
    t.string   "email"
    t.string   "image"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "workouts", force: :cascade do |t|
    t.integer  "map_my_fitness_id"
    t.boolean  "has_time_series"
    t.float    "distance"
    t.float    "average_speed"
    t.float    "active_time"
    t.float    "elapsed_time"
    t.float    "metabolic_energy"
    t.integer  "map_my_fitness_route_id"
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "route_id"
    t.float    "temperature"
    t.datetime "starting_datetime"
    t.string   "local_timezone"
  end

  add_index "workouts", ["route_id"], name: "index_workouts_on_route_id", using: :btree
  add_index "workouts", ["user_id"], name: "index_workouts_on_user_id", using: :btree

  add_foreign_key "routes", "locations"
  add_foreign_key "workouts", "routes"
  add_foreign_key "workouts", "users"
end
