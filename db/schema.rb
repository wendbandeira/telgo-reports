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

ActiveRecord::Schema.define(version: 20141024172056) do

  create_table "groups", force: true do |t|
    t.string   "name"
    t.string   "codequeue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "queue_logs", force: true do |t|
    t.string "time",      limit: 26,  default: ""
    t.string "callid",    limit: 32,  default: "", null: false
    t.string "queuename", limit: 32,  default: "", null: false
    t.string "agent",     limit: 32,  default: "", null: false
    t.string "event",     limit: 32,  default: "", null: false
    t.string "data1",     limit: 100, default: "", null: false
    t.string "data2",     limit: 32,  default: "", null: false
    t.string "data3",     limit: 32,  default: "", null: false
    t.string "data4",     limit: 32,  default: "", null: false
    t.string "data5",     limit: 32,  default: "", null: false
  end

end
