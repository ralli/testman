class CreateTeststepruns < ActiveRecord::Migration
  def self.up
    create_table :teststepruns do |t|
      t.integer :testcaserun_id, :nulls => false
      t.integer :position, :nulls => false, :default => 0
      t.integer :teststep_id
      t.string  :status, :nulls => false, :limit => 20
      t.string  :result, :nulls => false, :limit => 20
      t.timestamps
    end

    add_index(:teststepruns, [:testcaserun_id, :position])
    add_index(:teststepruns, [:testcaserun_id, :teststep_id])

  end

  def self.down
    drop_table :teststepruns
  end
end
