class CreateTeststepruns < ActiveRecord::Migration
  def self.up
    create_table :teststepruns do |t|
      t.integer :testcaserun_id, :nulls => false
      t.integer :position, :nulls => false, :default => 0
      t.integer :teststep_id
      t.string  :status, :nulls => false, :limit => 20
      t.string  :result, :nulls => false, :limit => 20
      t.integer :created_by_id, :nulls => false
      t.integer :edited_by_id, :nulls => false
      t.timestamps
    end

    add_index(:teststepruns, [:testcaserun_id, :position])
    add_index(:teststepruns, [:testcaserun_id, :teststep_id])
    add_index(:teststepruns, :created_by_id)
    add_index(:teststepruns, :edited_by_id)
  end

  def self.down
    drop_table :teststepruns
  end
end
