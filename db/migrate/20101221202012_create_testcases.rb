class CreateTestcases < ActiveRecord::Migration
  def self.up
    create_table :testcases do |t|
      t.string  :key, :nulls => false, :limit => 10
      t.integer :version, :nulls => false
      t.integer :project_id, :nulls => false
      t.string  :name, :nulls => false, :limit => 80
      t.boolean :enabled, :nulls => false, :default => true
      t.integer :created_by_id, :nulls => false
      t.integer :edited_by_id, :nulls => false
      t.text    :description
      t.string  :test_area, :nulls => false, :limit => 20
      t.string  :test_variety, :nulls => false, :limit => 20
      t.string  :test_level, :nulls => false, :limit => 20
      t.string  :execution_type, :nulls => false, :limit => 20
      t.string  :test_status, :nulls => false, :limit => 20
      t.string  :test_priority, :nulls => false, :limit => 20
      t.string  :test_method, :nulls => false, :limit => 20
      t.timestamps
    end

    add_index(:testcases, [:key, :version])
    add_index(:testcases, :project_id)
    add_index(:testcases, :name)
    add_index(:testcases, :created_by_id)
    add_index(:testcases, :edited_by_id)
    add_index(:testcases, :test_area)
    add_index(:testcases, :test_variety)
    add_index(:testcases, :test_level)
    add_index(:testcases, :execution_type)
    add_index(:testcases, :test_status)
    add_index(:testcases, :test_priority)
    add_index(:testcases, :test_method)
  end

  def self.down
    drop_table :testcases
  end
end
