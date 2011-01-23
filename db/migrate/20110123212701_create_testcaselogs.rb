class CreateTestcaselogs < ActiveRecord::Migration
  def self.up
    create_table :testcaselogs do |t|
      t.integer :testcaserun_id, :nulls => false
      t.integer :created_by_id, :nulls => false
      t.string  :status, :nulls => false, :limit => 20
      t.string  :result, :nulls => false, :limit => 20
      t.timestamps
    end

    add_index :testcaselogs, :testcaserun_id
    add_index :testcaselogs, :created_by_id
  end

  def self.down
    drop_table :testcaselogs
  end
end
