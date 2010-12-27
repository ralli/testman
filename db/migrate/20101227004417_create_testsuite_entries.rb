class CreateTestsuiteEntries < ActiveRecord::Migration
  def self.up
    create_table :testsuite_entries do |t|
      t.integer :testsuite_id, :nulls => false
      t.integer :testcase_id, :nulls => false
      t.integer :position, :nulls => false      
    end

    add_index(:testsuite_entries, :testsuite_id)
    add_index(:testsuite_entries, :testcase_id)
    add_index(:testsuite_entries, [:testsuite_id, :position])
  end

  def self.down
    drop_table :testsuite_entries
  end
end
