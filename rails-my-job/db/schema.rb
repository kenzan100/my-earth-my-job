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

ActiveRecord::Schema.define(version: 2021_04_18_133037) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.integer "resource_id"
    t.string "author_type"
    t.integer "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "equipment", force: :cascade do |t|
    t.string "name"
    t.float "hourly_rate"
    t.string "timestamps"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status"
    t.index ["name"], name: "index_equipment_on_name", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.integer "status_changed_to"
    t.integer "equipment_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "goods", force: :cascade do |t|
    t.string "name"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "job_attributes", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "binary", default: false
    t.float "required_months"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "equipment_id"
    t.boolean "ditractor", default: false
  end

  create_table "my_attributes", force: :cascade do |t|
    t.string "name", null: false
    t.float "spent_months"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "possessions", force: :cascade do |t|
    t.integer "quantity"
    t.integer "good_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["good_id"], name: "index_possessions_on_good_id"
  end

  create_table "references", force: :cascade do |t|
    t.text "url", null: false
    t.string "referencible_type"
    t.integer "referencible_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["referencible_type", "referencible_id"], name: "index_references_on_referencible"
  end

  create_table "registers", force: :cascade do |t|
    t.time "start_hour"
    t.time "end_hour"
    t.string "registerable_type"
    t.integer "registerable_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["registerable_type", "registerable_id"], name: "index_registers_on_registerable"
  end

  create_table "spends", force: :cascade do |t|
    t.integer "good_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["good_id"], name: "index_spends_on_good_id"
  end

  create_table "time_speeds", force: :cascade do |t|
    t.datetime "starting"
    t.datetime "ending"
    t.integer "multiplier"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "possessions", "goods"
  add_foreign_key "spends", "goods"
end
