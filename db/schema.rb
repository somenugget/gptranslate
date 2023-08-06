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

ActiveRecord::Schema[7.0].define(version: 2023_07_29_144349) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authorizations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "provider", null: false
    t.string "uid", null: false
    t.string "token"
    t.string "refresh_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_authorizations_on_user_id"
  end

  create_table "phrases", force: :cascade do |t|
    t.bigint "translation_id", null: false
    t.integer "status", default: 0, null: false
    t.string "lang_from", null: false
    t.string "lang_to", null: false
    t.string "text_from", null: false
    t.string "text_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translation_id"], name: "index_phrases_on_translation_id"
  end

  create_table "phrases_0", id: :bigint, default: -> { "nextval('phrases_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "translation_id", null: false
    t.integer "status", default: 0, null: false
    t.string "lang_from", null: false
    t.string "lang_to", null: false
    t.string "text_from", null: false
    t.string "text_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translation_id"], name: "phrases_0_translation_id_idx"
  end

  create_table "phrases_1", id: :bigint, default: -> { "nextval('phrases_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "translation_id", null: false
    t.integer "status", default: 0, null: false
    t.string "lang_from", null: false
    t.string "lang_to", null: false
    t.string "text_from", null: false
    t.string "text_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translation_id"], name: "phrases_1_translation_id_idx"
  end

  create_table "phrases_2", id: :bigint, default: -> { "nextval('phrases_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "translation_id", null: false
    t.integer "status", default: 0, null: false
    t.string "lang_from", null: false
    t.string "lang_to", null: false
    t.string "text_from", null: false
    t.string "text_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translation_id"], name: "phrases_2_translation_id_idx"
  end

  create_table "phrases_3", id: :bigint, default: -> { "nextval('phrases_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "translation_id", null: false
    t.integer "status", default: 0, null: false
    t.string "lang_from", null: false
    t.string "lang_to", null: false
    t.string "text_from", null: false
    t.string "text_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translation_id"], name: "phrases_3_translation_id_idx"
  end

  create_table "phrases_4", id: :bigint, default: -> { "nextval('phrases_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "translation_id", null: false
    t.integer "status", default: 0, null: false
    t.string "lang_from", null: false
    t.string "lang_to", null: false
    t.string "text_from", null: false
    t.string "text_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translation_id"], name: "phrases_4_translation_id_idx"
  end

  create_table "phrases_5", id: :bigint, default: -> { "nextval('phrases_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "translation_id", null: false
    t.integer "status", default: 0, null: false
    t.string "lang_from", null: false
    t.string "lang_to", null: false
    t.string "text_from", null: false
    t.string "text_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translation_id"], name: "phrases_5_translation_id_idx"
  end

  create_table "phrases_6", id: :bigint, default: -> { "nextval('phrases_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "translation_id", null: false
    t.integer "status", default: 0, null: false
    t.string "lang_from", null: false
    t.string "lang_to", null: false
    t.string "text_from", null: false
    t.string "text_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translation_id"], name: "phrases_6_translation_id_idx"
  end

  create_table "phrases_7", id: :bigint, default: -> { "nextval('phrases_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "translation_id", null: false
    t.integer "status", default: 0, null: false
    t.string "lang_from", null: false
    t.string "lang_to", null: false
    t.string "text_from", null: false
    t.string "text_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translation_id"], name: "phrases_7_translation_id_idx"
  end

  create_table "phrases_8", id: :bigint, default: -> { "nextval('phrases_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "translation_id", null: false
    t.integer "status", default: 0, null: false
    t.string "lang_from", null: false
    t.string "lang_to", null: false
    t.string "text_from", null: false
    t.string "text_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translation_id"], name: "phrases_8_translation_id_idx"
  end

  create_table "phrases_9", id: :bigint, default: -> { "nextval('phrases_id_seq'::regclass)" }, force: :cascade do |t|
    t.bigint "translation_id", null: false
    t.integer "status", default: 0, null: false
    t.string "lang_from", null: false
    t.string "lang_to", null: false
    t.string "text_from", null: false
    t.string "text_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["translation_id"], name: "phrases_9_translation_id_idx"
  end

  create_table "translations", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_translations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.boolean "guest", default: false
    t.string "first_name"
    t.string "last_name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "authorizations", "users"
  add_foreign_key "phrases", "translations"
  add_foreign_key "phrases_0", "translations"
  add_foreign_key "phrases_1", "translations"
  add_foreign_key "phrases_2", "translations"
  add_foreign_key "phrases_3", "translations"
  add_foreign_key "phrases_4", "translations"
  add_foreign_key "phrases_5", "translations"
  add_foreign_key "phrases_6", "translations"
  add_foreign_key "phrases_7", "translations"
  add_foreign_key "phrases_8", "translations"
  add_foreign_key "phrases_9", "translations"
  add_foreign_key "translations", "users"
end
