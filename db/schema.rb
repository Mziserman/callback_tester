# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_09_25_172408) do
  create_table "belongs_tos", force: :cascade do |t|
    t.integer "callbacker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["callbacker_id"], name: "index_belongs_tos_on_callbacker_id"
  end

  create_table "callbackers", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "has_one_id"
    t.integer "has_many_id"
    t.index ["has_many_id"], name: "index_callbackers_on_has_many_id"
    t.index ["has_one_id"], name: "index_callbackers_on_has_one_id"
  end

  create_table "has_manies", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "has_ones", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "belongs_tos", "callbackers"
end
