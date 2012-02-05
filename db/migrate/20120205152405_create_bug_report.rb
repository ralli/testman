class CreateBugReport < ActiveRecord::Migration
  def up
    create_table :bug_reports do |t|
      t.integer :testsuiterun_id, :nulls => false
      t.integer :testcaserun_id
      t.integer :teststeprun_id
      t.string :title, :nulls => false, :limit => 100
      t.string :bug_number, :limit => 20
      t.text :message
      t.timestamps
    end

    add_index :bug_reports, :testsuiterun_id
    add_index :bug_reports, :testcaserun_id
    add_index :bug_reports, :teststeprun_id
    add_index :bug_reports, :bug_number
  end

  def down
    drop_table :bug_reports
  end
end
