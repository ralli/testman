class CreateTestsuiteruns < ActiveRecord::Migration
  def self.up
    create_table :testsuiteruns do |t|
      t.integer :testsuite_id
      t.string :status, :nulls => false, :limit => 20
      t.string :result, :nulls => false, :limit => 20
      t.integer :current_testcaserun
      t.integer :created_by_id, :nulls => false
      t.integer :edited_by_id, :nulls => false
      t.timestamps
    end

    add_index(:testsuiteruns, :testsuite_id)
    add_index(:testsuiteruns, :status)
    add_index(:testsuiteruns, :result)
    add_index(:testsuiteruns, :created_by_id)
    add_index(:testsuiteruns, :edited_by_id)
  end

  def self.down
    drop_table :testsuiteruns
  end
end
