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

ActiveRecord::Schema[7.1].define(version: 2024_02_23_015429) do
  create_table "addresses", force: :cascade do |t|
    t.string "street_address"
    t.string "line2"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.integer "hospital_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_addresses_on_hospital_id"
  end

  create_table "comparisons", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "procedure_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["procedure_id"], name: "index_comparisons_on_procedure_id"
    t.index ["user_id"], name: "index_comparisons_on_user_id"
  end

  create_table "hospitals", force: :cascade do |t|
    t.string "hospital_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "insurances", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price"
  end

  create_table "procedure_costs", force: :cascade do |t|
    t.integer "procedure_id", null: false
    t.integer "hospital_id", null: false
    t.string "total_price"
    t.integer "insurance_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["hospital_id"], name: "index_procedure_costs_on_hospital_id"
    t.index ["insurance_id"], name: "index_procedure_costs_on_insurance_id"
    t.index ["procedure_id"], name: "index_procedure_costs_on_procedure_id"
  end

  create_table "procedures", force: :cascade do |t|
    t.string "cpt_code"
    t.string "name"
    t.string "department"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "zipcode"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "hospitals"
  add_foreign_key "comparisons", "procedures"
  add_foreign_key "comparisons", "users"
  add_foreign_key "procedure_costs", "hospitals"
  add_foreign_key "procedure_costs", "insurances"
  add_foreign_key "procedure_costs", "procedures"
end
