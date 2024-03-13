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

ActiveRecord::Schema[7.1].define(version: 2024_03_13_062534) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accessories", force: :cascade do |t|
    t.string "code"
    t.string "name"
    t.text "description"
    t.string "category"
    t.string "warranty"
    t.string "color"
    t.decimal "price"
    t.integer "discount"
    t.decimal "total_price"
    t.integer "stock"
    t.string "imagen"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "accessory_images", force: :cascade do |t|
    t.string "image_name"
    t.string "image_url"
    t.bigint "accessory_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["accessory_id"], name: "index_accessory_images_on_accessory_id"
  end

  create_table "product_images", force: :cascade do |t|
    t.string "image_url"
    t.bigint "product_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_name"
    t.index ["product_id"], name: "index_product_images_on_product_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "color"
    t.decimal "price"
    t.integer "discount"
    t.decimal "total_price"
    t.integer "stock"
    t.string "code"
    t.string "imagen"
    t.string "warranty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "category"
  end

  add_foreign_key "accessory_images", "accessories"
  add_foreign_key "product_images", "products"
end
