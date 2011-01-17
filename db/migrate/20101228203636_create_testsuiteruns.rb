class CreateTestsuiteruns < ActiveRecord::Migration
  def self.up
    create_table :testsuiteruns do |t|
      t.integer :testsuite_id
      t.string :status, :nulls => false, :limit => 20
      t.string :result, :nulls => false, :limit => 20
      t.integer :created_by_id, :nulls => false
      t.integer :edited_by_id, :nulls => false
      t.string  :show_mode, :nulls => false, :default => 'current', :limit => 10
      
      t.timestamps
    end

    add_index(:testsuiteruns, :testsuite_id)
    add_index(:testsuiteruns, :created_by_id)
    add_index(:testsuiteruns, :edited_by_id)
  end

  def self.down
    drop_table :testsuiteruns
  end
end
