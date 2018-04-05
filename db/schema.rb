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

ActiveRecord::Schema.define(version: 20180322181950) do

  create_table "applicants", force: :cascade do |t|
    t.integer "submission_id", null: false
    t.datetime "submitted_at"
    t.string "uin", null: false
    t.string "first_name"
    t.string "last_name"
    t.boolean "status"
    t.string "comment"
    t.string "updated_by"
    t.datetime "updated_at", null: false
    t.integer "last_4_uin"
    t.string "tamu_email"
    t.string "other_email"
    t.string "phone"
    t.string "gender"
    t.date "birthdate"
    t.string "classification"
    t.string "major"
    t.string "anticipated_graduation"
    t.string "address"
    t.text "extracurriculars"
    t.string "shirt_size"
    t.string "parent_name"
    t.string "parent_phone"
    t.string "parent_email"
    t.string "parent_address"
    t.string "parent_city"
    t.string "parent_state"
    t.string "parent_zip"
    t.string "alt_contact_1_name"
    t.string "alt_contact_1_phone"
    t.string "alt_contact_1_email"
    t.string "alt_contact_1_address"
    t.string "alt_contact_1_city"
    t.string "alt_contact_1_state"
    t.string "alt_contact_1_zip"
    t.string "alt_contact_2_name"
    t.string "alt_contact_2_phone"
    t.string "alt_contact_2_email"
    t.string "alt_contact_2_address"
    t.string "alt_contact_2_city"
    t.string "alt_contact_2_state"
    t.string "alt_contact_2_zip"
    t.string "insurance_provider"
    t.string "insurance_policy_number"
    t.string "insurance_policy_holder_name"
    t.date "last_tetanus_booster_date"
    t.text "drug_allergies"
    t.text "food_allergies"
    t.boolean "dietary_none"
    t.boolean "dietary_red_meat"
    t.boolean "dietary_vegan"
    t.boolean "dietary_vegetarian"
    t.boolean "dietary_dairy_free"
    t.boolean "dietary_gluten_free"
    t.text "dietary_other"
    t.text "medications"
    t.boolean "accommodations_none"
    t.boolean "accommodations_auditory"
    t.boolean "accommodations_visual"
    t.boolean "accommodations_physical"
    t.text "accommodations_other"
    t.text "other_medical_concerns"
    t.boolean "policy_agreement"
    t.boolean "behavior_agreement"
    t.boolean "personal_responsibility_agreement"
    t.boolean "liability_waiver"
    t.boolean "photo_release"
    t.boolean "camp_counselor"
    t.boolean "crew_counselor"
    t.string "pick_up_only"
    t.text "camp_history"
    t.text "no_show_explanation"
    t.boolean "abuse_agreement"
    t.text "app_question_1"
    t.text "app_question_2"
    t.text "app_question_3"
    t.text "crew_question"
    t.datetime "created_at", null: false
  end

  create_table "camps", force: :cascade do |t|
    t.string "name", null: false
    t.integer "session_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["session_id"], name: "index_camps_on_session_id"
  end

  create_table "chairs", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "camp_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["camp_id"], name: "index_chairs_on_camp_id"
    t.index ["user_id"], name: "index_chairs_on_user_id"
  end

  create_table "evaluations", force: :cascade do |t|
    t.integer "chair_id"
    t.integer "applicant_id"
    t.string "rating"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_evaluations_on_applicant_id"
    t.index ["chair_id"], name: "index_evaluations_on_chair_id"
  end

  create_table "session_availabilities", force: :cascade do |t|
    t.integer "session_id", null: false
    t.integer "applicant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_session_availabilities_on_applicant_id"
    t.index ["session_id"], name: "index_session_availabilities_on_session_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "name", null: false
    t.integer "year", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "google_uid"
    t.string "uin"
    t.string "name"
    t.string "email"
    t.string "role"
    t.string "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
