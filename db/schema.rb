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

ActiveRecord::Schema.define(:version => 20120122174600) do

  create_table "projects", :force => true do |t|
    t.string   "name",       :limit => 80, :null => false
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
  end

  add_index "projects", ["name"], :name => "index_projects_on_name"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "testcase_attachments", :force => true do |t|
    t.integer  "testcase_id"
    t.integer  "position"
    t.string   "attachment_file_name"
    t.string   "attachment_content_type"
    t.integer  "attachment_file_size"
    t.datetime "attachment_updated_at"
  end

  add_index "testcase_attachments", ["testcase_id", "position"], :name => "index_testcase_attachments_on_testcase_id_and_position"

  create_table "testcaselogs", :force => true do |t|
    t.integer  "testcaserun_id"
    t.integer  "created_by_id"
    t.string   "status",         :limit => 20
    t.string   "result",         :limit => 20
    t.datetime "created_at",                   :null => false
    t.datetime "updated_at",                   :null => false
  end

  add_index "testcaselogs", ["created_by_id"], :name => "index_testcaselogs_on_created_by_id"
  add_index "testcaselogs", ["testcaserun_id"], :name => "index_testcaselogs_on_testcaserun_id"

  create_table "testcaseruns", :force => true do |t|
    t.integer  "testsuiterun_id"
    t.integer  "position",                      :default => 0
    t.integer  "testcase_id"
    t.string   "status",          :limit => 20
    t.string   "result",          :limit => 20
    t.integer  "created_by_id"
    t.integer  "edited_by_id"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
  end

  add_index "testcaseruns", ["created_by_id"], :name => "index_testcaseruns_on_created_by_id"
  add_index "testcaseruns", ["edited_by_id"], :name => "index_testcaseruns_on_edited_by_id"
  add_index "testcaseruns", ["testcase_id"], :name => "index_testcaseruns_on_testcase_id"
  add_index "testcaseruns", ["testsuiterun_id", "position"], :name => "index_testcaseruns_on_testsuiterun_id_and_position"

  create_table "testcases", :force => true do |t|
    t.string   "key",             :limit => 10
    t.integer  "version"
    t.integer  "project_id"
    t.string   "name",            :limit => 80
    t.boolean  "enabled",                       :default => true
    t.integer  "created_by_id"
    t.integer  "edited_by_id"
    t.text     "description"
    t.string   "test_area",       :limit => 20
    t.string   "test_variety",    :limit => 20
    t.string   "test_level",      :limit => 20
    t.string   "execution_type",  :limit => 20
    t.string   "test_status",     :limit => 20
    t.string   "test_priority",   :limit => 20
    t.string   "test_method",     :limit => 20
    t.datetime "created_at",                                      :null => false
    t.datetime "updated_at",                                      :null => false
    t.string   "cached_tag_list"
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

  create_table "teststepruns", :force => true do |t|
    t.integer  "testcaserun_id"
    t.integer  "position",                     :default => 0
    t.integer  "teststep_id"
    t.string   "status",         :limit => 20
    t.string   "result",         :limit => 20
    t.integer  "created_by_id"
    t.integer  "edited_by_id"
    t.datetime "created_at",                                  :null => false
    t.datetime "updated_at",                                  :null => false
  end

  add_index "teststepruns", ["created_by_id"], :name => "index_teststepruns_on_created_by_id"
  add_index "teststepruns", ["edited_by_id"], :name => "index_teststepruns_on_edited_by_id"
  add_index "teststepruns", ["testcaserun_id", "position"], :name => "index_teststepruns_on_testcaserun_id_and_position"
  add_index "teststepruns", ["testcaserun_id", "teststep_id"], :name => "index_teststepruns_on_testcaserun_id_and_teststep_id"

  create_table "teststeps", :force => true do |t|
    t.integer  "testcase_id"
    t.integer  "position"
    t.text     "step"
    t.text     "expected_result"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "teststeps", ["testcase_id", "position"], :name => "index_teststeps_on_testcase_id_and_position"

  create_table "testsuite_entries", :force => true do |t|
    t.integer "testsuite_id"
    t.integer "testcase_id"
    t.integer "position"
  end

  add_index "testsuite_entries", ["testcase_id"], :name => "index_testsuite_entries_on_testcase_id"
  add_index "testsuite_entries", ["testsuite_id", "position"], :name => "index_testsuite_entries_on_testsuite_id_and_position"
  add_index "testsuite_entries", ["testsuite_id"], :name => "index_testsuite_entries_on_testsuite_id"

  create_table "testsuiteruns", :force => true do |t|
    t.integer  "testsuite_id"
    t.string   "status",        :limit => 20
    t.string   "result",        :limit => 20
    t.integer  "created_by_id"
    t.integer  "edited_by_id"
    t.string   "show_mode",     :limit => 10, :default => "current"
    t.datetime "created_at",                                         :null => false
    t.datetime "updated_at",                                         :null => false
  end

  add_index "testsuiteruns", ["created_by_id"], :name => "index_testsuiteruns_on_created_by_id"
  add_index "testsuiteruns", ["edited_by_id"], :name => "index_testsuiteruns_on_edited_by_id"
  add_index "testsuiteruns", ["testsuite_id"], :name => "index_testsuiteruns_on_testsuite_id"

  create_table "testsuites", :force => true do |t|
    t.string   "key",           :limit => 10
    t.integer  "version"
    t.boolean  "enabled",                     :default => true
    t.string   "name",          :limit => 80
    t.text     "description"
    t.integer  "created_by_id"
    t.integer  "edited_by_id"
    t.integer  "project_id"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
  end

  add_index "testsuites", ["created_by_id"], :name => "index_testsuites_on_created_by_id"
  add_index "testsuites", ["edited_by_id"], :name => "index_testsuites_on_edited_by_id"
  add_index "testsuites", ["key"], :name => "index_testsuites_on_key"
  add_index "testsuites", ["project_id"], :name => "index_testsuites_on_project_id"

  create_table "tracker_settings", :force => true do |t|
    t.string  "type",                 :limit => 60
    t.integer "project_id"
    t.string  "site"
    t.string  "user",                 :limit => 40
    t.string  "password",             :limit => 40
    t.integer "tracker_project_id"
    t.string  "tracker_project_name"
    t.string  "tracker_project_key",  :limit => 60
  end

  add_index "tracker_settings", ["project_id"], :name => "index_tracker_settings_on_project_id"
  add_index "tracker_settings", ["type"], :name => "index_tracker_settings_on_type"

  create_table "users", :force => true do |t|
    t.string   "login",              :limit => 20, :null => false
    t.string   "first_name",         :limit => 80
    t.string   "last_name",          :limit => 80
    t.string   "email",              :limit => 80, :null => false
    t.string   "password_digest"
    t.integer  "current_project_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.string   "locale",             :limit => 10
  end

  add_index "users", ["current_project_id"], :name => "index_users_on_current_project_id"
  add_index "users", ["last_name"], :name => "index_users_on_last_name"
  add_index "users", ["login"], :name => "index_users_on_login", :unique => true

end
