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

ActiveRecord::Schema[7.1].define(version: 2024_03_04_063836) do
  create_table "chats", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", comment: "对话", force: :cascade do |t|
    t.bigint "user_id", comment: "用户"
    t.string "name", comment: "名称"
    t.string "model", comment: "模型"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_chats_on_user_id"
  end

  create_table "dialogues", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", comment: "对话记录", force: :cascade do |t|
    t.json "user_content", comment: "用户输入"
    t.text "assistant_content", size: :medium, comment: "AI 回答"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "messages", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", comment: "消息", force: :cascade do |t|
    t.bigint "chat_id"
    t.text "user_content", comment: "用户输入"
    t.text "assistant_content", comment: "模型回答"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chat_id"], name: "index_messages_on_chat_id"
  end

  create_table "users", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", comment: "用户表", force: :cascade do |t|
    t.string "username", comment: "用户名"
    t.string "password_digest", comment: "密码"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
