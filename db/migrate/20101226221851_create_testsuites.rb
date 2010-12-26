class CreateTestsuites < ActiveRecord::Migration
  def self.up
    create_table :testsuites do |t|
      t.string :key, :limit => 10
      t.integer :version, :nulls => false
      t.boolean :enabled, :nulls => false, :default => true
      t.string :name, :limit => 80
      t.text :description
      t.integer :created_by_id, :nulls => false
      t.integer :edited_by_id, :nulls => false
      t.integer :project_id, :nulls => false

      t.timestamps
    end

    add_index(:testsuites, :key)
    add_index(:testsuites, :project_id)
    add_index(:testsuites, :created_by_id)
    add_index(:testsuites, :edited_by_id)
  end

  def self.down
    drop_table :testsuites
  end
end
