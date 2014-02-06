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

ActiveRecord::Schema.define(version: 20140206190844) do

  create_table "answers", force: true do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.boolean  "upped"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id"
  add_index "answers", ["user_id"], name: "index_answers_on_user_id"

  create_table "movies", force: true do |t|
    t.string   "name"
    t.string   "poster_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movies_parties", force: true do |t|
    t.integer "movie_id"
    t.integer "party_id"
  end

  add_index "movies_parties", ["movie_id"], name: "index_movies_parties_on_movie_id"
  add_index "movies_parties", ["party_id"], name: "index_movies_parties_on_party_id"

  create_table "movies_questions", force: true do |t|
    t.integer "movie_id"
    t.integer "question_id"
  end

  add_index "movies_questions", ["movie_id"], name: "index_movies_questions_on_movie_id"
  add_index "movies_questions", ["question_id"], name: "index_movies_questions_on_question_id"

  create_table "parties", force: true do |t|
    t.string   "vanity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "party_id"
  end

end
