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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140223131443) do

  create_table "blog_articles", :force => true do |t|
    t.string   "title"
    t.boolean  "online"
    t.integer  "author_id"
    t.text     "content"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "blog_post_files", :force => true do |t|
    t.integer  "blog_post_id"
    t.string   "attachment_uid"
    t.string   "attachment_file_name"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "blog_posts", :force => true do |t|
    t.string   "title"
    t.date     "published_at"
    t.text     "content"
    t.integer  "author_id"
    t.string   "permalink"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "subtitle"
    t.string   "slug"
  end

  add_index "blog_posts", ["slug"], :name => "index_blogs_on_slug"

  create_table "club_teams", :force => true do |t|
    t.integer  "club_id"
    t.integer  "team_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "club_teams", ["club_id"], :name => "index_club_teams_on_club_id"
  add_index "club_teams", ["team_id"], :name => "index_club_teams_on_team_id"

  create_table "clubs", :force => true do |t|
    t.string   "name"
    t.string   "zps",                  :limit => 5
    t.string   "country_organization"
    t.string   "region_organisation"
    t.string   "county_organization"
    t.boolean  "delete_flag"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "team_id"
  end

  create_table "combats", :force => true do |t|
    t.integer  "league_id"
    t.integer  "combatday_id"
    t.integer  "home_team_id"
    t.integer  "guest_team_id"
    t.string   "home_team_name"
    t.string   "guest_team_name"
    t.string   "homeboard_1"
    t.string   "homeboard_2"
    t.string   "homeboard_3"
    t.string   "homeboard_4"
    t.string   "homeboard_5"
    t.string   "homeboard_6"
    t.string   "homeboard_7"
    t.string   "homeboard_8"
    t.string   "guestboard_1"
    t.string   "guestboard_2"
    t.string   "guestboard_3"
    t.string   "guestboard_4"
    t.string   "guestboard_5"
    t.string   "guestboard_6"
    t.string   "guestboard_7"
    t.string   "guestboard_8"
    t.string   "result"
    t.string   "result_1"
    t.string   "result_2"
    t.string   "result_3"
    t.string   "result_4"
    t.string   "result_5"
    t.string   "result_6"
    t.string   "result_7"
    t.string   "result_8"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "comments", :force => true do |t|
    t.integer  "owner_id",         :null => false
    t.integer  "commentable_id",   :null => false
    t.string   "commentable_type", :null => false
    t.text     "body",             :null => false
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "event_series", :force => true do |t|
    t.integer  "frequency",  :default => 1
    t.string   "period",     :default => "weekly"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "all_day",    :default => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.integer  "owner_id"
    t.string   "category"
    t.string   "place"
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.text     "description"
    t.datetime "starttime"
    t.datetime "endtime"
    t.boolean  "all_day",         :default => false
    t.integer  "event_series_id"
    t.datetime "created_at",                         :null => false
    t.datetime "updated_at",                         :null => false
    t.string   "place"
    t.integer  "owner_id"
    t.string   "category"
    t.integer  "league_id"
  end

  create_table "friendly_id_slugs", :force => true do |t|
    t.string   "slug",                         :null => false
    t.integer  "sluggable_id",                 :null => false
    t.string   "sluggable_type", :limit => 40
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type"], :name => "index_friendly_id_slugs_on_slug_and_sluggable_type", :unique => true
  add_index "friendly_id_slugs", ["sluggable_id"], :name => "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], :name => "index_friendly_id_slugs_on_sluggable_type"

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.string   "scraper_link"
    t.integer  "boards"
    t.integer  "subs_bench"
    t.integer  "age_limit"
    t.boolean  "girls_only"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
    t.integer  "parent_id"
    t.integer  "lft"
    t.integer  "rgt"
    t.integer  "depth"
    t.text     "teams"
    t.text     "gaming_days"
    t.string   "state"
    t.string   "season"
    t.integer  "district_code"
    t.string   "kick_off"
    t.decimal  "durance",       :precision => 5, :scale => 2
  end

  create_table "mercury_images", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "old_roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "organization_players", :force => true do |t|
    t.string   "index"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "fide_title"
    t.integer  "pkz"
    t.string   "status"
    t.integer  "birth_year"
    t.integer  "dwz"
    t.integer  "elo"
    t.string   "club"
    t.integer  "club_id"
    t.integer  "dewis_club_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "gender"
  end

  add_index "organization_players", ["index"], :name => "index_organization_players_on_index"

  create_table "players", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "member_id"
    t.string   "state"
    t.string   "gender"
    t.string   "last_poll"
    t.integer  "dwz"
    t.integer  "dwz_index"
    t.integer  "elo"
    t.string   "title"
    t.integer  "birth_year"
    t.boolean  "delete_flag"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "roles_users", :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  create_table "team_players", :force => true do |t|
    t.integer  "team_id"
    t.integer  "organization_player_id"
    t.text     "results"
    t.float    "points"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "league_id"
    t.integer  "board_position"
  end

  add_index "team_players", ["organization_player_id"], :name => "index_team_players_on_organization_player_id"
  add_index "team_players", ["team_id"], :name => "index_team_players_on_team_id"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.integer  "league_id"
    t.integer  "position"
    t.decimal  "points",             :precision => 10, :scale => 0
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.integer  "dewis_club_id"
    t.string   "board_points"
    t.decimal  "board_points_plus",  :precision => 5,  :scale => 1
    t.decimal  "board_points_minus", :precision => 5,  :scale => 1
    t.text     "results_hash"
    t.string   "slug"
  end

  add_index "teams", ["slug"], :name => "index_teams_on_slug", :unique => true

  create_table "tournament_players", :force => true do |t|
    t.integer  "tournament_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "fide_title"
    t.string   "dwz"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.text     "result"
    t.string   "registrar"
  end

  create_table "tournaments", :force => true do |t|
    t.string   "title"
    t.string   "modus"
    t.string   "rounds"
    t.string   "state"
    t.string   "referee"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.text     "rules"
    t.text     "invitation"
    t.text     "events"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "last_name"
    t.string   "first_name"
    t.date     "birth_date"
    t.date     "member_since"
    t.integer  "dwz"
    t.string   "title"
    t.string   "username"
    t.string   "dsb_id"
    t.string   "address"
    t.string   "zip"
    t.string   "location"
    t.string   "phone"
    t.string   "mobile"
    t.string   "gender"
    t.string   "status"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "authentication_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
