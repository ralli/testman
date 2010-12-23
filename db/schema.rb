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

ActiveRecord::Schema.define(:version => 20101221202012) do

  create_table "projects", :force => true do |t|
    t.string   "name",       :limit => 80, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "projects", ["name"], :name => "index_projects_on_name"

  create_table "testcases", :force => true do |t|
    t.string   "key",            :limit => 10
    t.integer  "version"
    t.integer  "project_id"
    t.string   "name",           :limit => 80
    t.boolean  "enabled",                      :default => true
    t.integer  "created_by_id"
    t.integer  "edited_by_id"
    t.text     "description"
    t.string   "test_area",      :limit => 20
    t.string   "test_variety",   :limit => 20
    t.string   "test_level",     :limit => 20
    t.string   "execution_type", :limit => 20
    t.string   "test_status",    :limit => 20
    t.string   "test_priority",  :limit => 20
    t.string   "test_method",    :limit => 20
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "testcases", ["created_by_id"], :name => "index_testcases_on_created_by_id"
  add_index "testcases", ["edited_by_id"], :name => "index_testcases_on_edited_by_id"
  add_index "testcases", ["execution_type"], :name => "index_testcases_on_execution_type"
  add_index "testcases", ["key", "version"], :name => "index_testcases_on_key_and_version"
  add_index "testcases", ["name"], :name => "index_testcases_on_name"
  add_index "testcases", ["project_id"], :name => "index_testcases_on_project_id"
  add_index "testcases", ["test_area"], :name => "index_testcases_on_test_area"
  add_index "testcases", ["test_level"], :name => "index_testcases_on_test_level"
  add_index "testcases", ["test_method"], :name => "index_testcases_on_test_method"
  add_index "testcases", ["test_priority"], :name => "index_testcases_on_test_priority"
  add_index "testcases", ["test_status"], :name => "index_testcases_on_test_status"
  add_index "testcases", ["test_variety"], :name => "index_testcases_on_test_variety"

  create_table "users", :force => true do |t|
    t.string   "login",               :limit => 20,                :null => false
    t.string   "first_name",          :limit => 80
    t.string   "last_name",           :limit => 80
    t.string   "email",               :limit => 80,                :null => false
    t.string   "crypted_password",                                 :null => false
    t.string   "password_salt",                                    :null => false
    t.string   "persistence_token",                                :null => false
    t.string   "single_access_token",                              :null => false
    t.integer  "login_count",                       :default => 0, :null => false
    t.integer  "failed_login_count",                :default => 0, :null => false
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["last_name"], :name => "index_users_on_last_name"
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
