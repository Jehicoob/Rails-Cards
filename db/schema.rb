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

ActiveRecord::Schema.define(version: 2022_11_02_153458) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "username"
    t.string "nickname"
    t.date "birth"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_accounts_on_user_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "card_scores", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "deck_id", null: false
    t.bigint "card_id", null: false
    t.float "total_score"
    t.integer "plays"
    t.float "average"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_id"], name: "index_card_scores_on_card_id"
    t.index ["deck_id"], name: "index_card_scores_on_deck_id"
    t.index ["user_id"], name: "index_card_scores_on_user_id"
  end

  create_table "cards", force: :cascade do |t|
    t.text "question"
    t.text "description"
    t.bigint "deck_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deck_id"], name: "index_cards_on_deck_id"
    t.index ["user_id"], name: "index_cards_on_user_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "deck_scores", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "deck_id", null: false
    t.float "score"
    t.float "qualification"
    t.integer "successful_cards"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deck_id"], name: "index_deck_scores_on_deck_id"
    t.index ["user_id"], name: "index_deck_scores_on_user_id"
  end

  create_table "decks", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "category_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "owner_id", null: false
    t.string "code"
    t.string "font_color"
    t.string "deck_color"
    t.index ["category_id"], name: "index_decks_on_category_id"
    t.index ["owner_id"], name: "index_decks_on_owner_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "deck_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["deck_id"], name: "index_favorites_on_deck_id"
    t.index ["user_id", "deck_id"], name: "index_favorites_on_user_id_and_deck_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "scores", force: :cascade do |t|
    t.bigint "card_id", null: false
    t.bigint "user_id", null: false
    t.integer "sum_total"
    t.integer "plays"
    t.integer "prom"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["card_id"], name: "index_scores_on_card_id"
    t.index ["user_id"], name: "index_scores_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "accounts", "users"
  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "card_scores", "cards"
  add_foreign_key "card_scores", "decks"
  add_foreign_key "card_scores", "users"
  add_foreign_key "cards", "decks"
  add_foreign_key "cards", "users"
  add_foreign_key "deck_scores", "decks"
  add_foreign_key "deck_scores", "users"
  add_foreign_key "decks", "categories"
  add_foreign_key "decks", "users", column: "owner_id"
  add_foreign_key "favorites", "decks"
  add_foreign_key "favorites", "users"
  add_foreign_key "scores", "cards"
  add_foreign_key "scores", "users"
end
