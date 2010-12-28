class CreateTestcaseruns < ActiveRecord::Migration
  def self.up
    create_table :testcaseruns do |t|
      t.integer :testsuiterun_id
      t.integer :position, :nulls => false, :default => 0
      t.integer :testcase_id
      t.string  :status, :nulls => false, :limit => 20
      t.string  :result, :nulls => false, :limit => 20
      t.integer :created_by_id, :nulls => false
      t.integer :edited_by_id, :nulls => false      
      t.timestamps
    end

    add_index(:testcaseruns, [:testsuiterun_id, :position])
    add_index(:testcaseruns, :testcase_id)
    add_index(:testcaseruns, :created_by_id)
    add_index(:testcaseruns, :edited_by_id)
  end

  def self.down
    drop_table :testcaseruns
  end
end
